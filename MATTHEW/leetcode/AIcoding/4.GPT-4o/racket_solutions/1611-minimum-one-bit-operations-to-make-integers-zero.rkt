(define (minimumOneBitOperations n)
  (define (helper x)
    (if (= x 0) 0
        (+ (expt 2 (floor (log x 2))) (helper (xor x (expt 2 (floor (log x 2))))))))
  (helper n))