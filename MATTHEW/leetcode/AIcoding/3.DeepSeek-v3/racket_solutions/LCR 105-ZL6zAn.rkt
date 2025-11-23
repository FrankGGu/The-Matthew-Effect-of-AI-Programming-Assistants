(define (max-area-of-island grid)
  (define rows (length grid))
  (if (zero? rows) 0
      (let ([cols (length (car grid))])
        (let ([max-area 0])
          (for ([i (in-range rows)])
            (for ([j (in-range cols)])
              (when (equal? (list-ref (list-ref grid i) j) 1)
                (set! max-area (max max-area (dfs grid i j rows cols))))))
          max-area))))

(define (dfs grid i j rows cols)
  (if (or (< i 0) (>= i rows) (< j 0) (>= j cols) (equal? (list-ref (list-ref grid i) j) 0))
      0
      (begin
        (list-set! (list-ref grid i) j 0)
        (+ 1 
           (dfs grid (add1 i) j rows cols)
           (dfs grid (sub1 i) j rows cols)
           (dfs grid i (add1 j) rows cols)
           (dfs grid i (sub1 j) rows cols)))))