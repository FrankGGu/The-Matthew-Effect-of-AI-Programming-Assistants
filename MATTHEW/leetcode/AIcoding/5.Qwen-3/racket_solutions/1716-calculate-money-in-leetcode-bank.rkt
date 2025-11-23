(define (total-money n)
  (define (helper i total)
    (if (> i n)
        total
        (helper (+ i 1) (+ total (* (quotient (- i 1) 7) 1)))))
  (helper 1 0))