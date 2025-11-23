(define (count-even n)
  (define (digit-sum x)
    (if (= x 0)
        0
        (+ (modulo x 10) (digit-sum (quotient x 10)))))
  (define (even-sum? x)
    (= (modulo (digit-sum x) 2) 0))
  (define (count-helper x count)
    (if (> x n)
        count
        (count-helper (+ x 1) (if (even-sum? x) (+ count 1) count))))
  (count-helper 1 0))

(count-even n)