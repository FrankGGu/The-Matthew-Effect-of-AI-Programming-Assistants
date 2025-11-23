(define (minOperations n x)
  (define (helper n x ops)
    (cond
      [(= x 0) ops]
      [(or (< x 0) (= n 0)) +inf.0]
      [else (min (helper n (- x 1) (+ ops 1))
                 (helper (- n 1) x (+ ops 1)))]))
  (helper n x 0))

(define (minOperationsToConvert n x)
  (minOperations n x))