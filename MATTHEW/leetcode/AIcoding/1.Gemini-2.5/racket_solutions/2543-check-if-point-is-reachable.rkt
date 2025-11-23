(define (check-if-point-is-reachable targetX targetY)
  (let ((g (gcd targetX targetY)))
    (and (> g 0)
         (= (bitwise-and g (- g 1)) 0))))