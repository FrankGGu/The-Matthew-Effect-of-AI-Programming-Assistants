(define (getMaximumGold grid)
  (define (dfs x y visited)
    (if (or (< x 0) (>= x (length grid)) (< y 0) (>= (length (list-ref grid x)) (length grid)) (not (= (list-ref (list-ref grid x) y) 0)))
        0
        (begin
          (define gold (list-ref (list-ref grid x) y))
          (set! (list-ref (list-ref grid x) y) 0)
          (define max-gold (max
                             (dfs (+ x 1) y visited)
                             (dfs (- x 1) y visited)
                             (dfs x (+ y 1) visited)
                             (dfs x (- y 1) visited)))
          (set! (list-ref (list-ref grid x) y) gold)
          (+ gold max-gold))))

  (define max-gold 0)
  (for ([i (in-range (length grid))])
    (for ([j (in-range (length (list-ref grid i)))])
      (when (> (list-ref (list-ref grid i) j) 0)
        (set! max-gold (max max-gold (dfs i j '()))))))
  max-gold)