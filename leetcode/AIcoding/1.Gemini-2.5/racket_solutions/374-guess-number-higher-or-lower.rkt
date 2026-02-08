(define (guess-number n)
  (let loop ((low 1) (high n))
    (let* ((mid (+ low (quotient (- high low) 2)))
           (res (guess mid)))
      (cond
        ((= res 0) mid)
        ((= res -1) (loop low (- mid 1)))
        ((= res 1) (loop (+ mid 1) high))))))