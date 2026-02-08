(define (exploreCamp grid)
  (define (valid? x y)
    (and (>= x 0) (< x (length grid))
         (>= y 0) (< y (length (vector-ref grid x)))))

  (define (dfs x y visited)
    (if (or (not (valid? x y))
            (vector-ref (vector-ref grid x) y) #f
            (set-member? visited (cons x y)))
        0
        (begin
          (set-add! visited (cons x y))
          (+ 1
             (dfs (+ x 1) y visited)
             (dfs (- x 1) y visited)
             (dfs x (+ y 1) visited)
             (dfs x (- y 1) visited)))))

  (define max-area 0)
  (define visited (make-set))

  (for ([i (in-range (length grid))])
    (for ([j (in-range (length (vector-ref grid i)))])
      (when (and (vector-ref (vector-ref grid i) j) (not (set-member? visited (cons i j))))
        (set! max-area (max max-area (dfs i j visited))))))

  max-area)