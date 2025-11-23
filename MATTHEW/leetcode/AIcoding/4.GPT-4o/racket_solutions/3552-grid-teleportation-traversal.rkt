(define (grid-teleportation-traversal grid)
  (define (dfs x y visited)
    (if (or (< x 0) (>= x (length grid)) 
            (< y 0) (>= y (length (vector-ref grid 0)))
            (vector-ref visited x y))
        0
        (begin
          (vector-set! visited x y #t)
          (+ 1
             (dfs (+ x 1) y visited)
             (dfs (- x 1) y visited)
             (dfs x (+ y 1) visited)
             (dfs x (- y 1) visited))))
    )
  (define visited (make-vector (length grid) (lambda () (make-vector (length (vector-ref grid 0)) #f))))
  (dfs 0 0 visited))

(grid-teleportation-traversal grid)