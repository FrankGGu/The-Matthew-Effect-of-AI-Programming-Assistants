(define (max-area-of-island grid)
  (define rows (vector-length grid))
  (if (zero? rows) 0
      (let ([cols (vector-length (vector-ref grid 0))])
        (let loop ([i 0] [max-area 0])
          (if (>= i rows) max-area
              (let inner-loop ([j 0] [current-max max-area])
                (if (>= j cols) (loop (add1 i) current-max)
                    (if (zero? (vector-ref (vector-ref grid i) j))
                        (inner-loop (add1 j) current-max)
                        (let ([area (dfs grid i j rows cols)])
                          (inner-loop (add1 j) (max current-max area)))))))))))

(define (dfs grid i j rows cols)
  (if (or (< i 0) (>= i rows) (< j 0) (>= j cols) (zero? (vector-ref (vector-ref grid i) j)))
      0
      (begin
        (vector-set! (vector-ref grid i) j 0)
        (+ 1
           (dfs grid (add1 i) j rows cols)
           (dfs grid (sub1 i) j rows cols)
           (dfs grid i (add1 j) rows cols)
           (dfs grid i (sub1 j) rows cols)))))