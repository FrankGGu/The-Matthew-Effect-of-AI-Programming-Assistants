(define (shortestCommonSupersequence s1 s2)
  (define m (string-length s1))
  (define n (string-length s2))

  (define lcs-table (make-vector (+ m 1) (make-vector (+ n 1) 0)))

  (for ([i (in-range 1 (+ m 1))])
    (for ([j (in-range 1 (+ n 1))])
      (if (equal? (string-ref s1 (- i 1)) (string-ref s2 (- j 1)))
          (vector-set! (vector-ref lcs-table i) j (+ 1 (vector-ref (vector-ref lcs-table (- i 1)) (- j 1))))
          (vector-set! (vector-ref lcs-table i) j (max (vector-ref (vector-ref lcs-table (- i 1)) j) (vector-ref (vector-ref lcs-table i) (- j 1)))))))

  (define (reconstruct-scs i j)
    (cond
      [(zero? i) (substring s2 0 j)]
      [(zero? j) (substring s1 0 i)]
      [(equal? (string-ref s1 (- i 1)) (string-ref s2 (- j 1)))
       (string-append (reconstruct-scs (- i 1) (- j 1)) (string (string-ref s1 (- i 1))))]
      [else
       (if (> (vector-ref (vector-ref lcs-table (- i 1)) j) (vector-ref (vector-ref lcs-table i) (- j 1)))
           (string-append (reconstruct-scs (- i 1) j) (string (string-ref s1 (- i 1))))
           (string-append (reconstruct-scs i (- j 1)) (string (string-ref s2 (- j 1)))))]))

  (reconstruct-scs m n))