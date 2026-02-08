(define (isReachable x1 y1 x2 y2)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))
  (define g (gcd (abs (- x1 x2)) (abs (- y1 y2))))
  (= (modulo x1 g) (modulo x2 g) (modulo y1 g) (modulo y2 g)))

(isReachable x1 y1 x2 y2)