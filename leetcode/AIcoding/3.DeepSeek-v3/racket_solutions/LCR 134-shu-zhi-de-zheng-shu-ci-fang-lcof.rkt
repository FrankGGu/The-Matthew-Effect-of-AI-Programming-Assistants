(define (my-pow x n)
  (define (fast-expt x n)
    (cond
      [(= n 0) 1.0]
      [(negative? n) (/ 1.0 (fast-expt x (- n)))]
      [(even? n) (let ([half (fast-expt x (/ n 2))]) (* half half))]
      [else (* x (fast-expt x (- n 1)))]))
  (fast-expt x n))