(define (min-non-zero-product p)
  (define mod (expt 10 9) 7)
  (define (fast-pow base exp mod)
    (cond
      [(zero? exp) 1]
      [(even? exp)
       (let ((half (fast-pow base (/ exp 2) mod)))
         (modulo (* half half) mod))]
      [else
       (modulo (* base (fast-pow base (- exp 1) mod)) mod)]))

  (let ((n (- (expt 2 p) 2)))
    (modulo (* (expt 2 p -1) (fast-pow (- (expt 2 p) 1) n mod)) mod)))