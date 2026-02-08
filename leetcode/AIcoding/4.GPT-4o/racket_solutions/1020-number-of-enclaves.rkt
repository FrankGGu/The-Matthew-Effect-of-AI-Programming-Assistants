(define (numEnclaves grid)
  (define (in-bounds? x y)
    (and (>= x 0) (< x (length grid)) (>= y 0) (< y (length (first grid)))))

  (define (dfs x y)
    (if (or (not (in-bounds? x y)) (not (= (list-ref (list-ref grid x) y) 1)))
        0
        (begin
          (set! (list-ref (list-ref grid x) y) 2)
          (+ 1 (dfs (+ x 1) y) (dfs (- x 1) y) (dfs x (+ y 1)) (dfs x (- y 1))))))

  (define (mark-boundary)
    (for ([i (in-range (length grid))])
      (for ([j (in-range (length (first grid)))])
        (when (or (= i 0) (= i (- (length grid) 1)) (= j 0) (= j (- (length (first grid)) 1)))
          (when (= (list-ref (list-ref grid i) j) 1)
            (dfs i j)))))

  (mark-boundary)

  (define count 0)
  (for ([i (in-range (length grid))])
    (for ([j (in-range (length (first grid)))])
      (when (= (list-ref (list-ref grid i) j) 1)
        (set! count (+ count (dfs i j))))))

  count)

(numEnclaves '((0 0 0 0) (1 0 0 0) (0 1 1 0) (0 0 0 0)))