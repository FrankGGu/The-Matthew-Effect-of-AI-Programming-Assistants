(define (hasAllCodes s k)
  (define total-codes (expt 2 k))
  (define seen (make-hash))
  (define len (string-length s))

  (for ([i (in-range (- len k) + 1)])
    (hash-set! seen (substring s i (+ i k)) #t))

  (= (hash-count seen) total-codes))