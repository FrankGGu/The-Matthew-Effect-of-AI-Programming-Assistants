(define (min-deletion-size strs)
  (define N (vector-length strs))
  (define L (string-length (vector-ref strs 0)))

  (define dp (make-vector L 1))

  (define (can-columns-follow? col-i col-j)
    (for/and ([k (in-range N)])
      (char<=? (string-ref (vector-ref strs k) col-i)
               (string-ref (vector-ref strs k) col-j))))

  (for ([j (in-range L)])
    (for ([i (in-range j)])
      (when (can-columns-follow? i j)
        (vector-set! dp j (max (vector-ref dp j) (+ 1 (vector-ref dp i)))))))

  (define max-kept-columns 0)
  (for ([val (in-vector dp)])
    (set! max-kept-columns (max max-kept-columns val)))

  (- L max-kept-columns))