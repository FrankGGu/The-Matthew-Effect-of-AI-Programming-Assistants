(define (monkey-move n)
  (define mod 1000000007)
  (define (pow x y)
    (cond
      [(zero? y) 1]
      [(even? y) (modulo (sqr (pow x (quotient y 2))) mod)]
      [else (modulo (* x (pow x (sub1 y))) mod)]))
  (modulo (- (pow 2 n) 2) mod))