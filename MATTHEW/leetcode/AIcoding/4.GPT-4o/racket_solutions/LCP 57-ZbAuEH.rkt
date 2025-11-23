(define (mole-game n m)
  (define (helper x y)
    (if (or (< x 0) (>= x n) (< y 0) (>= y m))
        0
        (+ 1 (helper (add1 x) y) 
              (helper (sub1 x) y) 
              (helper x (add1 y)) 
              (helper x (sub1 y)))))
  (helper 0 0))