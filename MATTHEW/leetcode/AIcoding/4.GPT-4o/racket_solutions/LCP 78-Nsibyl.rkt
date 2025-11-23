(define (numEnclaves A)
  (define (dfs x y)
    (if (or (< x 0) (>= x (length A)) (< y 0) (>= (length (vector-ref A 0)) y) (zero? (vector-ref (vector-ref A x) y)))
        0
        (begin
          (vector-set! (vector-ref A x) y 0)
          (+ 1 (dfs (+ x 1) y) (dfs (- x 1) y) (dfs x (+ y 1)) (dfs x (- y 1))))))

  (define rows (length A))
  (define cols (length (vector-ref A 0)))

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (when (or (= i 0) (= i (- rows 1)) (= j 0) (= j (- cols 1)))
        (when (= (vector-ref (vector-ref A i) j) 1)
          (dfs i j)))))

  (define count 0)
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (when (= (vector-ref (vector-ref A i) j) 1)
        (set! count (+ count (dfs i j))))))

  count)