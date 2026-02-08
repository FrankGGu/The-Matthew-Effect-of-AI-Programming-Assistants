(define (convertToTitle n)
  (cond
    [(= n 0) ""]
    [else (let* ([remainder (- (modulo n 26) 1)]
                  [quotient (quotient (- n remainder) 26)])
             (string-append (convertToTitle quotient)
                            (string (integer->char (+ remainder 65)))))]))