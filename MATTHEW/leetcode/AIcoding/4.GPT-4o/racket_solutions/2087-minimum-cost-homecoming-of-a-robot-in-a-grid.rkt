(define (min-cost-homecoming grid)
  (define n (length grid))
  (define m (length (car grid)))
  (define dp (make-vector n (make-vector m 0)))

  (vector-set! dp 0 0 (vector-ref (vector-ref grid 0) 0))

  (for ([i (in-range 1 n)])
    (vector-set! dp i 0 (+ (vector-ref (vector-ref grid i) 0) (vector-ref dp (- i 1) 0))))

  (for ([j (in-range 1 m)])
    (vector-set! dp 0 j (+ (vector-ref (vector-ref grid 0) j) (vector-ref dp 0 (- j 1)))))

  (for ([i (in-range 1 n)])
    (for ([j (in-range 1 m)])
      (vector-set! dp i j (+ (vector-ref (vector-ref grid i) j)
                              (min (vector-ref dp (- i 1) j)
                                   (vector-ref dp i (- j 1))))))
  )

  (vector-ref dp (- n 1) (- m 1)))