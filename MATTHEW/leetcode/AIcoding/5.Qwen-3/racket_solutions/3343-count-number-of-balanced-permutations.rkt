#lang racket

(define (count-balanced-permutations s)
  (define n (string-length s))
  (define freq (make-hash))
  (for ([c s])
    (hash-update! freq c add1 0))
  (define odd-count (for/sum ([v (in-hash-values freq)] #:when (odd? v)) 1))
  (if (and (even? n) (= odd-count 0))
      (let ([total (factorial n)])
        (for/fold ([res total]) ([k (in-hash-values freq)])
          (/ res (factorial k))))
      0))

(define (factorial x)
  (if (<= x 1) 1 (* x (factorial (- x 1)))))