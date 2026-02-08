(define (min-distance word1 word2)
  (define m (string-length word1))
  (define n (string-length word2))

  (define dp (make-vector (+ m 1)))
  (for ([i (in-range (+ m 1))])
    (vector-set! dp i (make-vector (+ n 1) 0)))

  (for ([i (in-range 1 (+ m 1))])
    (for ([j (in-range 1 (+ n 1))])
      (if (char=? (string-ref word1 (- i 1)) (string-ref word2 (- j 1)))
          (vector-set! (vector-ref dp i) j (+ 1 (vector-ref (vector-ref dp (- i 1)) (- j 1))))
          (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp (- i 1)) j)
                                                 (vector-ref (vector-ref dp i) (- j 1)))))))

  (define lcs-length (vector-ref (vector-ref dp m) n))
  (- (+ m n) (* 2 lcs-length)))