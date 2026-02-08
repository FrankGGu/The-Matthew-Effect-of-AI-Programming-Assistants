(define (my-pow x n)
  (cond [(zero? n) 1.0]
        [(negative? n) (my-pow (/ x) (- n))]
        [(even? n) (let ([half (my-pow x (/ n 2))]) (* half half))]
        [else (* x (my-pow x (- n 1)))]))