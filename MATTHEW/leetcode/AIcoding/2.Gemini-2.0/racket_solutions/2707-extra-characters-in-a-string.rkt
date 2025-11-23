(define (minExtraChar s dictionary)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) n))
  (vector-set! dp 0 0)

  (for ([i (in-range 1 (+ n 1))])
    (vector-set! dp i (add1 (vector-ref dp (sub1 i))))
    (for ([word (in-list dictionary)])
      (define word-len (string-length word))
      (when (and (>= i word-len)
                 (string=? (substring s (- i word-len) i) word))
        (vector-set! dp i (min (vector-ref dp i) (vector-ref dp (- i word-len)))))))

  (vector-ref dp n))