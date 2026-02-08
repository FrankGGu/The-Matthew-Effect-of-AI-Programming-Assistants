(define (min-path-sum grid)
  (let* ((m (vector-length grid))
         (n (vector-length (vector-ref grid 0)))
         (dp (make-vector m (make-vector n 0))))

    (vector-set! (vector-ref dp 0) 0 (vector-ref (vector-ref grid 0) 0))

    (for ([i (in-range 1 m)])
      (vector-set! (vector-ref dp i) 0 (+ (vector-ref (vector-ref grid i) 0) (vector-ref (vector-ref dp (- i 1)) 0))))

    (for ([j (in-range 1 n)])
      (vector-set! (vector-ref dp 0) j (+ (vector-ref (vector-ref grid 0) j) (vector-ref (vector-ref dp 0) (- j 1)))))

    (for ([i (in-range 1 m)])
      (for ([j (in-range 1 n)])
        (vector-set! (vector-ref dp i) j (+ (vector-ref (vector-ref grid i) j) (min (vector-ref (vector-ref dp (- i 1)) j) (vector-ref (vector-ref dp i) (- j 1))))))

    (vector-ref (vector-ref dp (- m 1)) (- n 1))))