(define (sum-of-good-numbers n)
  (define (is-good? num)
    (cond
      [(< num 1) #f]
      [else (let ([last-digit (modulo num 10)]
                  [rest-digits (quotient num 10)])
              (and (even? last-digit) (or (zero? rest-digits) (is-good? rest-digits))))]))
  (for/sum ([i (in-range 1 (add1 n))] #:when (is-good? i)) i))