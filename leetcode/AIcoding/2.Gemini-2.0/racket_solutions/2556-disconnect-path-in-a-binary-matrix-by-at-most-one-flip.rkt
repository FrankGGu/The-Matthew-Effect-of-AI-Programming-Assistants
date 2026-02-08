(define (is-valid-path? grid)
  (let* ([rows (length grid)]
         [cols (length (car grid))]
         [visited (make-vector rows (make-vector cols #f))]
         (define (dfs row col)
           (cond
             [(or (< row 0) (>= row rows) (< col 0) (>= col cols)
                  (vector-ref (vector-ref grid row) col) equal? 0
                  (vector-ref (vector-ref visited row) col))
              #f]
             [(= row (- rows 1)) (= col (- cols 1))
              #t]
             [else
              (vector-set! (vector-ref visited row) col #t)
              (or (dfs (+ row 1) col)
                  (dfs (- row 1) col)
                  (dfs row (+ col 1))
                  (dfs row (- col 1)))])))
    (dfs 0 0)))

(define (is-possible-to-disconnect? grid)
  (let* ([rows (length grid)]
         [cols (length (car grid))]
         (cond
           [(not (is-valid-path? grid))
            #t]
           [else
            (let loop ([i 0] [j 0])
              (cond
                [(>= i rows)
                 #f]
                [(>= j cols)
                 (loop (+ i 1) 0)]
                [(= (vector-ref (vector-ref grid i) j) 0)
                 (loop i (+ j 1))]
                [else
                 (let* ([original-value (vector-ref (vector-ref grid i) j)])
                   (vector-set! (vector-ref grid i) j 0)
                   (let ([result (not (is-valid-path? grid))])
                     (vector-set! (vector-ref grid i) j original-value)
                     (if result
                         #t
                         (loop i (+ j 1)))))])))]))))