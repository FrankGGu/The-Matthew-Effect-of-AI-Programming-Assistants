(define (mirror-reflection p q)
  (let* ((g (gcd p q))
         (p-prime (/ p g))
         (q-prime (/ q g)))
    (cond
      ((odd? p-prime) ; The beam effectively hits the right wall (x=p)
       (if (odd? q-prime) ; The beam effectively hits the top wall (y=p)
           1 ; Receiver 1 at (p,p)
           0)) ; The beam effectively hits the bottom wall (y=0) -> Receiver 0 at (p,0)
      (else ; The beam effectively hits the left wall (x=0)
       ; If p-prime is even, q-prime must be odd because gcd(p-prime, q-prime) = 1.
       ; So, the beam effectively hits the top wall (y=p)
       2)))) ; Receiver 2 at (0,p)