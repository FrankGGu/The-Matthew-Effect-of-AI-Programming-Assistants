(define (closedIsland grid)
  (define (dfs x y)
    (if (or (< x 0) (>= x (length grid)) (< y 0) (>= (length (vector-ref grid 0)) y))
        #f
        (if (equal? (vector-ref (vector-ref grid x) y) 1)
            #t
            (begin
              (vector-set! (vector-ref grid x) y 1)
              (and (dfs (- x 1) y)
                   (dfs (+ x 1) y)
                   (dfs x (- y 1))
                   (dfs x (+ y 1)))))))

  (define (mark-island x y)
    (if (or (< x 0) (>= x (length grid)) (< y 0) (>= (length (vector-ref grid 0)) y))
        #t
        (if (equal? (vector-ref (vector-ref grid x) y) 1)
            #t
            (begin
              (vector-set! (vector-ref grid x) y 1)
              (and (mark-island (- x 1) y)
                   (mark-island (+ x 1) y)
                   (mark-island x (- y 1))
                   (mark-island x (+ y 1)))))))

  (define closed-islands 0)
  (for* ([i (in-range (length grid))]
         [j (in-range (length (vector-ref grid 0)))])
    (when (and (equal? (vector-ref (vector-ref grid i) j) 0)
               (dfs i j))
      (set! closed-islands (+ closed-islands 1))))
  closed-islands)