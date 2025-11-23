(define (longest-special-path grid)
  (define (valid? x y)
    (and (>= x 0) (< x (length grid))
         (>= y 0) (< y (length (vector-ref grid x)))))

  (define (dfs x y visited)
    (if (not (valid? x y))
        0
        (let* ((val (vector-ref (vector-ref grid x) y))
               (new-visited (cons val visited)))
          (if (memv val visited)
              0
              (max (dfs (+ x 1) y new-visited)
                   (dfs (- x 1) y new-visited)
                   (dfs x (+ y 1) new-visited)
                   (dfs x (- y 1) new-visited)
                   (+ 1 (length new-visited)))))))

  (if (null? grid)
      0
      (dfs 0 0 '())))