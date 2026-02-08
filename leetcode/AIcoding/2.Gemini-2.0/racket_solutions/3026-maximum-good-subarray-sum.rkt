(define (maximum-subarray-sum nums k)
  (define n (length nums))
  (define prefix-sums (make-vector (+ n 1) 0))
  (for/fold ([i 0]) ([num (in-vector nums)] [idx (in-range n)])
    (vector-set! prefix-sums (+ idx 1) (+ (vector-ref prefix-sums idx) num))
    (+ i 1))

  (define min-prefix-sums (make-hash))
  (hash-set! min-prefix-sums 0 0)
  (define max-sum -inf.0)

  (for ([i (in-range 1 (+ n 1))])
    (define prefix-sum (vector-ref prefix-sums i))
    (define target (- prefix-sum k))
    (when (hash-has-key? min-prefix-sums target)
      (set! max-sum (max max-sum (- prefix-sum (hash-ref min-prefix-sums target)))))

    (define current-min (hash-ref min-prefix-sums prefix-sum +inf.0))
    (when (> current-min prefix-sum)
      (hash-set! min-prefix-sums prefix-sum prefix-sum)))

  (if (equal? max-sum -inf.0)
      0
      max-sum))