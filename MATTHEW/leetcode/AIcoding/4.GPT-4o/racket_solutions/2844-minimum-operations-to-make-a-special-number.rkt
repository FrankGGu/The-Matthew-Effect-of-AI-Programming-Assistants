(define (minOperations n)
  (define (is-special? x)
    (and (= (remainder x 10) 0) (not (= x 0))))

  (define (count-operations x count)
    (if (= x 0) count
        (if (is-special? x)
            (count-operations (quotient x 10) (+ count 1))
            (count-operations (sub1 x) (+ count 1)))))

  (count-operations n 0))

(minOperations 39) ; Example usage