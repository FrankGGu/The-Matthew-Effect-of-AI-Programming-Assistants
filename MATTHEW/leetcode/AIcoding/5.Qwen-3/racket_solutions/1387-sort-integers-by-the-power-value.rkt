(define (power-value n)
  (define (helper n count)
    (cond [(= n 1) count]
          [(even? n) (helper (/ n 2) (+ count 1))]
          [else (helper (+ (* n 3) 1) (+ count 1))]))
  (helper n 0))

(define (sort-integers-by-the-power-value nums)
  (sort nums (lambda (a b)
               (< (power-value a) (power-value b)))))