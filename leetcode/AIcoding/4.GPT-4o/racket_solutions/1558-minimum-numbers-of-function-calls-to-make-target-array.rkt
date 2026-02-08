(define (minOperations A)
  (define (count-operations x)
    (if (= x 0) 0
        (+ 1 (count-operations (quotient x 2)))))

  (define max-bits (apply max (map count-operations A)))
  (define total-operations (apply + (map (lambda (x) (count-operations x)) A)))
  (+ total-operations max-bits))

(minOperations '(3 2 2 4 1)) ; Example input