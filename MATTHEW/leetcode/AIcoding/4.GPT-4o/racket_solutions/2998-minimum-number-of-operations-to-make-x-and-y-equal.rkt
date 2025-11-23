(define (minOperations x y)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (mod a b))))
  (define (count-operations x y)
    (if (= x y)
        0
        (let ((g (gcd x y)))
          (+ (if (> x g) (/ (- x g) g) 0)
             (if (> y g) (/ (- y g) g) 0)))))
  (count-operations x y))