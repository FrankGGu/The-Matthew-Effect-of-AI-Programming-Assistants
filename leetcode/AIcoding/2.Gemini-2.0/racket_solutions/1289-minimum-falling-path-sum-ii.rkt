(define (min-falling-path-sum-ii matrix)
  (define n (vector-length matrix))
  (define m (vector-length (vector-ref matrix 0)))

  (define dp (make-vector n (make-vector m 0)))

  (for ([j (in-range m)])
    (vector-set! (vector-ref dp 0) j (vector-ref (vector-ref matrix 0) j)))

  (for ([i (in-range 1 n)])
    (for ([j (in-range m)])
      (define min-val +inf.0)
      (for ([k (in-range m)])
        (when (not (= j k))
          (set! min-val (min min-val (vector-ref (vector-ref dp (- i 1)) k)))))
      (vector-set! (vector-ref dp i) j (+ min-val (vector-ref (vector-ref matrix i) j)))))

  (apply min (vector->list (vector-ref dp (- n 1)))))