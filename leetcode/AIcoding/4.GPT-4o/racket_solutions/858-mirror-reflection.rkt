(define (mirror-reflection p q)
  (let ([gcd (lambda (a b)
               (if (= b 0)
                   a
                   (gcd b (modulo a b))))])
    (let* ([g (gcd p q)]
           [m (/ p g)]
           [n (/ q g)])
      (if (even? m)
          (if (even? n) 2 0)
          (if (even? n) 1 3)))))