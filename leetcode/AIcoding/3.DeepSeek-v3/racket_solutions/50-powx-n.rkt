(define/contract (my-pow x n)
  (-> flonum? exact-integer? flonum?)
  (define (fast-expt x n)
    (cond [(= n 0) 1.0]
          [(negative? n) (/ 1.0 (fast-expt x (- n)))]
          [(even? n) (let ([half (fast-expt x (quotient n 2))])
                       (* half half))]
          [else (* x (fast-expt x (sub1 n)))]))
  (fast-expt x n))