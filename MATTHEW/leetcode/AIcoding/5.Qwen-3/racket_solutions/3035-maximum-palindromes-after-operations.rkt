#lang racket

(define (max-palindromes s)
  (define freq (make-hash))
  (for ([c s])
    (hash-set! freq c (+ 1 (hash-ref freq c 0))))
  (define odd-count 0)
  (define total-length 0)
  (for ([v (in-hash-values freq)])
    (set! total-length (+ total-length v))
    (when (odd? v)
      (set! odd-count (+ odd-count 1))))
  (if (<= odd-count 1)
      total-length
      (- total-length (- odd-count 1))))