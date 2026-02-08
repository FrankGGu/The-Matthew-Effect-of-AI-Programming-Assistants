(define (simplified-fractions n)
  (apply append
         (for/list ([q (in-range 2 (+ n 1))])
           (for/list ([p (in-range 1 q)])
             (if (= (gcd p q) 1)
                 (list (format "~a/~a" p q))
                 '())))))