(define (min-score-triangulation values)
  (define n (vector-length values))
  (define dp (make-vector n (make-vector n 0)))

  (for ([len (in-range 3 (+ n 1))])
    (for ([i (in-range 0 (- n len -1))])
      (define j (+ i len -1))
      (vector-set! (vector-ref dp i) j +inf.0)
      (for ([k (in-range (+ i 1) j)])
        (define current-score
          (+ (vector-ref (vector-ref dp i) k)
             (vector-ref (vector-ref dp k) j)
             (* (vector-ref values i)
                (vector-ref values k)
                (vector-ref values j))))
        (when (< current-score (vector-ref (vector-ref dp i) j))
          (vector-set! (vector-ref dp i) j current-score))))))

  (vector-ref (vector-ref dp 0) (- n 1)))