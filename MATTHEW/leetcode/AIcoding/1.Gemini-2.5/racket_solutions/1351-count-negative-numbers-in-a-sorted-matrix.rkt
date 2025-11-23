(define (count-negatives grid)
  (let* ([m (vector-length grid)]
         [n (if (> m 0) (vector-length (vector-ref grid 0)) 0)])
    (let loop ([row 0]
               [total-negatives 0])
      (if (= row m)
          total-negatives
          (let inner-loop ([col 0]
                           [row-negatives 0])
            (if (= col n)
                (loop (+ row 1) (+ total-negatives row-negatives))
                (let ([val (vector-ref (vector-ref grid row) col)])
                  (if (< val 0)
                      (inner-loop (+ col 1) (+ row-negatives 1))
                      (inner-loop (+ col 1) row-negatives)))))))))