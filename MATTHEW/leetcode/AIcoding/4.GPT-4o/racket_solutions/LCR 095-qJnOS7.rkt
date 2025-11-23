(define (longestCommonSubsequence text1 text2)
  (define n (string-length text1))
  (define m (string-length text2))
  (define dp (make-vector (+ 1 n) (lambda () (make-vector (+ 1 m) 0))))

  (for ([i (in-range 1 (+ 1 n))])
    (for ([j (in-range 1 (+ 1 m))])
      (if (char=? (string-ref text1 (- i 1)) (string-ref text2 (- j 1)))
          (vector-set! (vector-ref dp i) j (+ 1 (vector-ref (vector-ref dp (- i 1)) (- j 1))))
          (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp (- i 1)) j) (vector-ref (vector-ref dp i) (- j 1)))))))

  (vector-ref (vector-ref dp n) m))