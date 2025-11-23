(define (num-enclaves grid)
  (define rows (length grid))
  (define cols (length (car grid)))

  (define (dfs i j)
    (cond
      [(or (< i 0) (>= i rows) (< j 0) (>= j cols) (= (list-ref (list-ref grid i) j) 0))
       #f]
      [else
       (set! (list-ref (list-ref grid i) j) 0)
       (dfs (+ i 1) j)
       (dfs (- i 1) j)
       (dfs i (+ j 1))
       (dfs i (- j 1))
       #t]))

  (for ([i (in-range rows)])
    (dfs i 0)
    (dfs i (- cols 1)))

  (for ([j (in-range cols)])
    (dfs 0 j)
    (dfs (- rows 1) j))

  (define count 0)
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (when (= (list-ref (list-ref grid i) j) 1)
        (set! count (+ count 1)))))

  count)