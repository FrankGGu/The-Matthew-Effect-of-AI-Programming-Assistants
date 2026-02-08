(define (smallest-divisible-digit-product n)
  (define (helper x)
    (if (= x 1)
        1
        (for/fold ([result 10])
                   ([i (in-range 1 10)]
                    #:when (zero? (modulo n i)))
          (min result (helper (/ n i))))))
  (helper n))