(define (max-number-of-balloons text)
  (define (count-chars s)
    (for/fold ([counts (hash)]) ([c s])
      (hash-update counts c add1 0)))

  (define balloon (count-chars "balloon"))

  (define text-counts (count-chars text))

  (define (min-occurrence)
    (for/fold ([min-vals +inf.0]) ([char (hash-keys balloon)])
      (min min-vals (quotient (hash-ref text-counts char 0) (hash-ref balloon char)))))

  (min-occurrence))