(define (min-operations matrix)
  (let* ([m (length matrix)]
         [n (if (zero? m) 0 (length (car matrix))])
    (if (or (zero? m) (zero? n)) 0
        (let loop ([col 0] [prev-row 0] [ops 0])
          (if (>= col n) ops
              (let ([current-col (map (lambda (row) (list-ref row col)) matrix)])
                (let ([sorted-col (sort current-col <)])
                  (if (and (> col 0) (<= (list-ref sorted-col 0) prev-row))
                      (loop (add1 col) prev-row (+ ops m))
                      (loop (add1 col) (last sorted-col) ops))))))))