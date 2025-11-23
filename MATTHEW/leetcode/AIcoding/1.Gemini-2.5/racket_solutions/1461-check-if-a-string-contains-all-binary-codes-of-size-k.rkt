#lang racket

(define (has-all-codes s k)
  (define n (string-length s))

  (define codes (make-hash-set))

  (for ([i (in-range 0 (+ (- n k) 1))])
    (define sub (substring s i (+ i k)))
    (hash-set-add! codes sub))

  (= (hash-set-count codes) (expt 2 k)))