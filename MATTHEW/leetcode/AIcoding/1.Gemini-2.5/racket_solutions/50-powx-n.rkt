(define (my-pow x n)
  (define (pow-iter base exp)
    (let loop ((current-base base)
               (current-exp exp)
               (result 1.0))
      (cond
        ((zero? current-exp) result)
        ((odd? current-exp)
         (loop (* current-base current-base)
               (quotient current-exp 2)
               (* result current-base)))
        (else ; even? current-exp
         (loop (* current-base current-base)
               (quotient current-exp 2)
               result)))))

  (cond
    ((zero? n) 1.0)
    ((negative? n)
     (pow-iter (/ 1.0 x) (- n)))
    (else ; positive n
     (pow-iter x n))))