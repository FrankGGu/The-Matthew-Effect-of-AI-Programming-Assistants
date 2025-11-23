(define (minimum-cost-good-caption words max-len)
  (define n (length words))
  (define dp (make-vector (add1 n) (make-vector (add1 max-len) +inf.0)))
  (vector-set! (vector-ref dp 0) 0 0)

  (for* ([i (in-range 1 (add1 n))]
         [j (in-range 1 (add1 max-len))])
    (define word-len (string-length (list-ref words (sub1 i))))
    (if (<= word-len j)
        (vector-set! (vector-ref dp i) j (min (vector-ref (vector-ref dp (sub1 i)) j)
                                               (+ (vector-ref (vector-ref dp (sub1 i)) (- j word-len)) 1)))
        (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (sub1 i)) j))))

  (vector-ref (vector-ref dp n) max-len))