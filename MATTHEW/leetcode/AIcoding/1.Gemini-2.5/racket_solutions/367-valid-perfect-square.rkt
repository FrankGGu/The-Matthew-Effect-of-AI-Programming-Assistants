(define (isPerfectSquare num)
  (if (= num 1) #t
      (let loop ((low 1)
                 (high num))
        (if (> low high) #f
            (let* ((mid (+ low (quotient (- high low) 2)))
                   (square (* mid mid)))
              (cond
                ((= square num) #t)
                ((< square num) (loop (+ mid 1) high))
                (else (loop low (- mid 1)))))))))