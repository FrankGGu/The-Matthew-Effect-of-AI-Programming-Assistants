(define (max-difference-score grid)
  (define (find-min-max lst)
    (values (apply min lst) (apply max lst)))

  (define (dfs i j)
    (if (or (>= i (length grid)) (>= j (length (vector-ref grid i))))
        0
        (let-values ([(min-val max-val) (find-min-max (list (vector-ref (vector-ref grid i) j) 
                                                             (if (> j 0) (vector-ref (vector-ref grid i) (- j 1)) 0)
                                                             (if (< j (- (length (vector-ref grid i)) 1)) (vector-ref (vector-ref grid i) (+ j 1)) 0)
                                                             (if (> i 0) (vector-ref (vector-ref grid (- i 1)) j) 0)
                                                             (if (< i (- (length grid) 1)) (vector-ref (vector-ref grid (+ i 1)) j) 0)))])
          (max (- max-val min-val)
               (max (dfs (+ i 1) j) (dfs i (+ j 1)))))))

  (dfs 0 0))