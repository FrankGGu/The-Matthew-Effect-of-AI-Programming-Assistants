(define (longest-common-subsequence text1 text2)
  (define m (string-length text1))
  (define n (string-length text2))
  (define dp (make-vector (+ m 1) (make-vector (+ n 1) 0)))

  (for ([i (in-range 1 (+ m 1))])
    (for ([j (in-range 1 (+ n 1))])
      (if (equal? (string-ref text1 (- i 1)) (string-ref text2 (- j 1)))
          (vector-set! (vector-ref dp i) j (+ 1 (vector-ref (vector-ref dp (- i 1)) (- j 1))))
          (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp (- i 1)) j) (vector-ref (vector-ref dp i) (- j 1)))))))

  (vector-ref (vector-ref dp m) n))