(define (min-non-zero-product p)
  (define MOD 1000000007)
  (define max-num (- (expt 2 p) 1))
  (define k (expt 2 (- p 1)))
  (define (fast-expt x n)
    (cond
      [(= n 0) 1]
      [(even? n) (modulo (expt (fast-expt x (/ n 2)) 2) MOD)]
      [else (modulo (* x (fast-expt x (- n 1))) MOD)]))
  (modulo (* max-num (fast-expt (- max-num 1) (- k 1))) MOD))