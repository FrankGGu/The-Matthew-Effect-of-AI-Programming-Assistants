(define (count-submatrices-with-all-ones matrix)
  (let* ([rows (length matrix)]
         [cols (length (first matrix))]
         [heights (make-vector cols 0)]
         [count 0])
    (for ([i (in-range rows)])
      (for ([j (in-range cols)])
        (if (= (list-ref (list-ref matrix i) j) 1)
            (vector-set! heights j (+ (vector-ref heights j) 1))
            (vector-set! heights j 0)))
      (let loop ([j 0])
        (if (= j cols)
            void
            (let* ([h (vector-ref heights j)]
                   [w 1]
                   [min-h h])
              (if (> h 0)
                  (begin
                    (set! count (+ count h))
                    (let loop2 ([k (+ j 1)])
                      (if (= k cols)
                          void
                          (let ([next-h (vector-ref heights k)])
                            (if (> next-h 0)
                                (begin
                                  (set! min-h (min min-h next-h))
                                  (set! w (+ w 1))
                                  (set! count (+ count min-h))
                                  (loop2 (+ k 1)))
                                void))))))
              (loop (+ j 1))))))
    count))