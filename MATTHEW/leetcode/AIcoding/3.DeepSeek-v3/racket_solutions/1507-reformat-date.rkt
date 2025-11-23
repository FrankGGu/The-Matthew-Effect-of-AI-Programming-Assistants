(define (reformat-date date)
  (let* ([parts (string-split date)]
         [day (car parts)]
         [month (cadr parts)]
         [year (caddr parts)]
         [day-num (substring day 0 (- (string-length day) 2))]
         [month-num (case month
                      [("Jan") "01"]
                      [("Feb") "02"]
                      [("Mar") "03"]
                      [("Apr") "04"]
                      [("May") "05"]
                      [("Jun") "06"]
                      [("Jul") "07"]
                      [("Aug") "08"]
                      [("Sep") "09"]
                      [("Oct") "10"]
                      [("Nov") "11"]
                      [("Dec") "12"]
                      [else "00"])])
    (string-append year "-" month-num "-" (if (< (string-length day-num) 2) (string-append "0" day-num) day-num))))