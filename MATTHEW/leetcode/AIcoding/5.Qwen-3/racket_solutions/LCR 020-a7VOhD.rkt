#lang racket

(define (count-substrings s)
  (define len (string-length s))
  (define count 0)
  (define (expand l r)
    (when (and (>= l 0) (< r len) (char=? (string-ref s l) (string-ref s r)))
      (set! count (+ count 1))
      (expand (- l 1) (+ r 1))))
  (for ([i (in-range len)])
    (expand i i)
    (expand i (+ i 1)))
  count)