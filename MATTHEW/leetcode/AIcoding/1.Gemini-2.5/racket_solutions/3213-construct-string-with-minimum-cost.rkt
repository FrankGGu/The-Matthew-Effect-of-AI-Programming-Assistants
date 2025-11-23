(define (minimum-cost target words costs)
  (define n (string-length target))
  (define dp (make-vector (+ n 1) +inf.0))

  (vector-set! dp 0 0)

  (for ([i (in-range 1 (+ n 1))])
    (for ([k (in-range (length words))])
      (define word (list-ref words k))
      (define cost (list-ref costs k))
      (define word-len (string-length word))

      (when (>= i word-len)
        (when (string=? (substring target (- i word-len) i) word)
          (when (not (= (vector-ref dp (- i word-len)) +inf.0))
            (vector-set! dp i
                         (min (vector-ref dp i)
                              (+ (vector-ref dp (- i word-len)) cost))))))))

  (if (= (vector-ref dp n) +inf.0)
      -1
      (vector-ref dp n)))