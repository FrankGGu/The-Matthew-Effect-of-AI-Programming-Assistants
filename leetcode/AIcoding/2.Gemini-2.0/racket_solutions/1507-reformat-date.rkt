(define (reformat-date date)
  (define (month-to-number month)
    (cond
      [(string=? month "Jan") "01"]
      [(string=? month "Feb") "02"]
      [(string=? month "Mar") "03"]
      [(string=? month "Apr") "04"]
      [(string=? month "May") "05"]
      [(string=? month "Jun") "06"]
      [(string=? month "Jul") "07"]
      [(string=? month "Aug") "08"]
      [(string=? month "Sep") "09"]
      [(string=? month "Oct") "10"]
      [(string=? month "Nov") "11"]
      [(string=? month "Dec") "12"]))

  (define parts (string-split date " "))
  (define day (string-replace (car parts) #rx"[a-z]+" ""))
  (define month (cadr parts))
  (define year (caddr parts))

  (string-append year "-" (month-to-number month) "-" (if (= (string-length day) 1) (string-append "0" day) day)))