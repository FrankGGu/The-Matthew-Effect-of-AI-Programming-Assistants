(define (drone-grid grid)
  (define (dfs x y visited)
    (if (or (< x 0) (>= x (length grid)) (< y 0) (>= (length (list-ref grid x)) (length grid)))
        0
        (if (or (equal? (list-ref (list-ref grid x) y) 0) (member (list x y) visited))
            0
            (begin
              (set! visited (cons (list x y) visited))
              (+ 1 (dfs (+ x 1) y visited)
                 (dfs (- x 1) y visited)
                 (dfs x (+ y 1) visited)
                 (dfs x (- y 1) visited))))))
  (define (count-drones)
    (define visited '())
    (for/fold ([count 0]) ([i (in-range (length grid))] [j (in-range (length (list-ref grid i)))])
      (if (equal? (list-ref (list-ref grid i) j) 1)
          (+ count (dfs i j visited))
          count)))
  (count-drones))