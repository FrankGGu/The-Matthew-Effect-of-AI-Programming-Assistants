(define (minOperations n)
  (define (helper x count)
    (if (= x 0)
        count
        (helper (if (even? x) (/ x 2) (- x 1)) (+ count 1))))
  (helper n 0))

(minOperations 39) ; Example call for testing