(define (countGoodPartitions s k)
  (define n (length s))
  (define mod 1000000007)

  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range i)])
      (when (<= (string->number (substring s j i)) k)
        (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp j)) mod)))))

  (vector-ref dp n))

(countGoodPartitions "1234" 4)