\name{setNumericRounding}
\alias{setNumericRounding}
\title{ Change or turn off numeric rounding }
\description{
  Change rounding to 0, 1 or 2 bytes when joining or grouping numeric (i.e. double) columns.
}
\usage{
setNumericRounding(x)
}
\arguments{
  \item{x}{ integer or numeric vector: 2, 1 or 0 byte rounding }
}
\details{
  Computers cannot represent some floating point numbers (such as 0.6) precisely, using base 2. This leads to unexpected behaviour when
  joining or grouping columns of type 'numeric'; i.e. 'double', see example below.  To deal with this automatically for convenience, 
  when joining or grouping, data.table rounds such data to apx 11 s.f. which is plenty of digits for many cases. This is achieved by
  rounding the last 2 bytes of the significand.  Where this is not enough, \code{setNumericRounding} can be used to reduce to 1 byte
  rounding, or no rounding for full precision.
}
\value{
    No return value. The new value is applied.
}
\seealso{
\url{http://en.wikipedia.org/wiki/Double-precision_floating-point_format}\cr
\url{http://en.wikipedia.org/wiki/Floating_point}\cr
\url{http://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html}
\if{html}{\out{<script type="text/javascript">var sc_project=6237851;var sc_invisible=1;var sc_security="518c93ca";</script><script type="text/javascript" src="http://www.statcounter.com/counter/counter.js"></script><noscript><div class="statcounter"><a title="web statistics" href="http://statcounter.com/free-web-stats/" target="_blank"><img class="statcounter" src="http://c.statcounter.com/6237851/0/518c93ca/1/" alt="web statistics"></a></div></noscript>}}
}
\examples{
    DT = data.table(a=seq(0,1,by=0.2),b=1:2, key="a")
    setNumericRounding(0)   # turn off rounding
    DT[.(0.4)]   # works
    DT[.(0.6)]   # no match, confusing since 0.6 is clearing there in DT
    
    setNumericRounding(2)   # restore default
    DT[.(0.6)]   # works as expected
    
    # using type 'numeric' for integers > 2^31 (typically ids)
    DT = data.table(id = c(1234567890123, 1234567890124, 1234567890125), val=1:3)
    DT[,.N,by=id]   # 1 row
    setNumericRounding(0)
    DT[,.N,by=id]   # 3 rows
    # better to use bit64::integer64 for such ids
    setNumericRounding(2)
}
\keyword{ data }

