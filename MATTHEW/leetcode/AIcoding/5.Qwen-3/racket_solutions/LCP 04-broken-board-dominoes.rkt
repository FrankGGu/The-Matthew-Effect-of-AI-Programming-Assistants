(define (can-Place-Dominoes n m)
  (define (count x y)
    (if (or (= x n) (= y m)) 0 (+ 1 (count (if (= x n) x (+ x 1)) (if (= y m) y (+ y 1))))))
  (let loop ((x 0) (y 0) (total 0))
    (if (or (= x n) (= y m))
        total
        (loop (if (= y (sub1 m)) (add1 x) x)
              (if (= y (sub1 m)) 0 (add1 y))
              (+ total (count x y))))))