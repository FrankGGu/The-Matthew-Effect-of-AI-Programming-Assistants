(define (sand-control grid)
  (define (in-bounds? x y)
    (and (>= x 0) (< x (length grid))
         (>= y 0) (< y (length (vector-ref grid 0)))))

  (define (dfs x y)
    (if (not (in-bounds? x y)) 
        0
        (if (not (= (vector-ref (vector-ref grid x) y) 1))
            0
            (begin
              (vector-set! (vector-ref grid x) y 0)
              (+ 1 (dfs (+ x 1) y)
                 (dfs (- x 1) y)
                 (dfs x (+ y 1))
                 (dfs x (- y 1))))))

  (define (count-sand-piles)
    (define count 0)
    (for ([i (in-range (length grid))])
      (for ([j (in-range (length (vector-ref grid 0)))])
        (when (= (vector-ref (vector-ref grid i) j) 1)
          (set! count (+ count (dfs i j))))))
    count)

  (count-sand-piles))