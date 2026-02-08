(define (word-break s word-dict)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) #f))
  (vector-set! dp 0 #t)

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 0 i)])
      (when (and (vector-ref dp j)
                 (member? (substring s j i) word-dict))
        (vector-set! dp i #t)
        (break))))

  (vector-ref dp n))