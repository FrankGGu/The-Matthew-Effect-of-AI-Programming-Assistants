#lang racket

(define (find-longest-harmonious-subsequence nums)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-set! freq n (+ (hash-ref freq n 0) 1))) nums)
  (define max-length 0)
  (for ([k (in-hash-keys freq)])
    (when (hash-has-key? freq (+ k 1))
      (set! max-length (max max-length (+ (hash-ref freq k) (hash-ref freq (+ k 1)))))))
  max-length)