(define (minimumSum (nums : (Vectorof Integer))) : Integer
  (define (digit-sum n)
    (if (= n 0)
        0
        (+ (modulo n 10) (digit-sum (quotient n 10)))))

  (define (replace-if-needed n)
    (if (>= n 10)
        (digit-sum n)
        n))

  (define new-nums (vector-map replace-if-needed nums))
  (apply + (vector->list new-nums)))