(define (longest-palindrome s)
  (define (count-chars s)
    (for/fold ([counts (hash)]) ([c s])
      (hash-update counts c add1 0)))

  (define counts (count-chars s))
  (define odd-count (for/first ([v (in-hash-values counts)] #:when (odd? v)) v))

  (define even-sum
    (for/sum ([v (in-hash-values counts)])
      (* (quotient v 2) 2)))

  (if odd-count
      (+ even-sum 1)
      even-sum))