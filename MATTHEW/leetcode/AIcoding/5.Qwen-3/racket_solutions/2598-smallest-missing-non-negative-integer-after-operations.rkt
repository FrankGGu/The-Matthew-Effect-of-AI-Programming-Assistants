#lang racket

(define/contract (non-negative-integer nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([s (set)]
        [n (length nums)])
    (for-each (lambda (x) (set-add! s x)) nums)
    (let loop ([i 0])
      (if (set-member? s i)
          (loop (+ i 1))
          i))))