(define (is-reachable x y t)
  (and (<= (abs x) t)
       (<= (abs y) t)
       (even? (- t (+ (abs x) (abs y))))))

(define (reachable-cell x y t)
  (is-reachable x y t))