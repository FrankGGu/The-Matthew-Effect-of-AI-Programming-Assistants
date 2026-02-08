(define (broken-board-dominoes N M board)
  (define (is-valid x y)
    (and (>= x 0) (< x N) (>= y 0) (< y M)))

  (define (dfs x y)
    (if (not (is-valid x y)) 
        0
        (if (equal? (vector-ref board x) (vector-ref (vector-ref board x) y)) 
            (begin
              (vector-set! board x (vector-set (vector-ref board x) y #\X))
              (+ 1 (dfs (+ x 1) y) (dfs (- x 1) y) (dfs x (+ y 1)) (dfs x (- y 1))))
            0)))

  (define count 0)
  (for* ([i (in-range N)] [j (in-range M)])
    (when (equal? (vector-ref (vector-ref board i) j) #\O)
      (set! count (+ count (dfs i j)))))

  count)