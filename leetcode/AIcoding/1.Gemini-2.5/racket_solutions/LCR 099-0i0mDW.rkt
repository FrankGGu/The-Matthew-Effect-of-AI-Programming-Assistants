(define (min-path-sum grid)
  (define m (length grid))
  (define n (length (car grid)))

  (define dp (make-vector m))
  (for ([i (in-range m)])
    (vector-set! dp i (make-vector n)))

  (vector-set! (vector-ref dp 0) 0 (list-ref (list-ref grid 0) 0))

  (for ([j (in-range 1 n)])
    (vector-set! (vector-ref dp 0) j
                 (+ (vector-ref (vector-ref dp 0) (- j 1))
                    (list-ref (list-ref grid 0) j))))

  (for ([i (in-range 1 m)])
    (vector-set! (vector-ref dp i) 0
                 (+ (vector-ref (vector-ref dp (- i 1)) 0)
                    (list-ref (list-ref grid i) 0))))

  (for ([i (in-range 1 m)])
    (for ([j (in-range 1 n)])
      (vector-set! (vector-ref dp i) j
                   (+ (min (vector-ref (vector-ref dp (- i 1)) j)
                           (vector-ref (vector-ref dp i) (- j 1)))
                      (list-ref (list-ref grid i) j)))))

  (vector-ref (vector-ref dp (- m 1)) (- n 1)))