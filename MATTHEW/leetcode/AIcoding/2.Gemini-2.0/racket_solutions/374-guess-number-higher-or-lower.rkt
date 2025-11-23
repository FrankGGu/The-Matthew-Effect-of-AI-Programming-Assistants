(define (guessNumber n)
  (let loop ((low 1) (high n))
    (let ((mid (quotient (+ low high) 2)))
      (cond
        ((= (guess mid) 0) mid)
        ((= (guess mid) 1) (loop (+ mid 1) high))
        (else (loop low (- mid 1)))))))