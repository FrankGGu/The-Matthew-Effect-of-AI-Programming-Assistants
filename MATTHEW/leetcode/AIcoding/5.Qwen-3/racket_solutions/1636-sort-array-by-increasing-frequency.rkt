#lang racket

(define (frequency-sort nums)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-set! freq n (+ 1 (hash-ref freq n 0)))) nums)
  (sort nums (lambda (a b)
               (let ((f-a (hash-ref freq a))
                     (f-b (hash-ref freq b)))
                 (if (= f-a f-b)
                     (> a b)
                     (< f-a f-b))))) )