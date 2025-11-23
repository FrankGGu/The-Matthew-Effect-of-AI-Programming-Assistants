(define (longest-increasing-path matrix)
  (if (null? matrix)
      0
      (let* ([m (length matrix)]
             [n (if (null? matrix) 0 (length (car matrix)))]
             [dp (make-vector (* m n) -1)]
             [dirs '((0 1) (1 0) (0 -1) (-1 0))])
        (define (dfs i j)
          (let ([pos (+ (* i n) j)])
            (if (>= (vector-ref dp pos) 0)
                (vector-ref dp pos)
                (let ([max-len 1])
                  (for ([dir dirs])
                    (let ([x (+ i (car dir))]
                          [y (+ j (cadr dir))])
                      (when (and (>= x 0) (< x m) (>= y 0) (< y n)
                                (> (list-ref (list-ref matrix x) y)
                                   (list-ref (list-ref matrix i) j)))
                        (set! max-len (max max-len (+ 1 (dfs x y)))))))
                  (vector-set! dp pos max-len)
                  max-len))))
        (let ([max-path 0])
          (for ([i (in-range m)])
            (for ([j (in-range n)])
              (set! max-path (max max-path (dfs i j)))))
          max-path))))