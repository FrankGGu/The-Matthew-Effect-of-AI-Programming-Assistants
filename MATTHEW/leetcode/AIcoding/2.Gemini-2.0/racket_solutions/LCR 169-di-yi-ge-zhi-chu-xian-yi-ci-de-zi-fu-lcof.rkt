(define (solve s)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) #f))
  (vector-set! dp 0 #t)

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 0 i)])
      (when (and (vector-ref dp j)
                 (string=? (substring s j i) "sha")
                 )
        (vector-set! dp i #t))))

  (vector-ref dp n))