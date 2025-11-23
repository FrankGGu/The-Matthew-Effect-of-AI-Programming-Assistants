#lang racket

(define (memoize f)
  (define cache (make-hash))
  (lambda (x)
    (if (hash-has-key? cache x)
        (hash-ref cache x)
        (let ([result (f x)])
          (hash-set! cache x result)
          result))))

(define (solve n)
  (define (helper n)
    (if (zero? n)
        1
        (if (= n 1)
            0
            (+ (helper (- n 1)) (helper (- n 2))))))
  (memoize helper n))

(define (and-not a b)
  (if (and a (not b)) 1 0))

(define (getResult n)
  (and-not (solve n) (solve (- n 1))))

(define (findResult n)
  (if (zero? n)
      1
      (getResult n)))

(define (calculate n)
  (findResult n))

(define (main n)
  (calculate n))

(provide main)