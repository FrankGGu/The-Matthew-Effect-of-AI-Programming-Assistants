#lang racket

(define (smallestValue n)
  (define (prime-factors x)
    (define (factors k)
      (if (<= k 1)
          '()
          (if (zero? (modulo x k))
              (cons k (factors (/ x k)))
              (factors (- k 1)))))
    (factors (floor (sqrt x))))

  (define (sum-of-factors x)
    (apply + (prime-factors x)))

  (define (reduce-value x)
    (if (<= x 1)
        x
        (reduce-value (sum-of-factors x))))

  (reduce-value n))

(smallestValue 12) ; Example input