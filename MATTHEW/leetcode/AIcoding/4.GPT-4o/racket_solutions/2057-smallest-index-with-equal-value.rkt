(define (smallestEqual nums)
  (for/fold ([min-index -1]) ([i (in-range (length nums))])
    (if (= (list-ref nums i) (modulo i 10))
        (if (or (= min-index -1) (< i min-index))
            i
            min-index)
        min-index)))