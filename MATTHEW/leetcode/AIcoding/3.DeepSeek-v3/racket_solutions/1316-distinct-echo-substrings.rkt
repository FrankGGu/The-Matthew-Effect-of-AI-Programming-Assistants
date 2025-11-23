#lang racket

(define (distinct-echo-substrings text)
  (define n (string-length text))
  (define seen (mutable-set))
  (for* ([i (in-range n)]
         [j (in-range (+ i 1) n]
         #:when (<= (* 2 (- j i)) (- n i))
    (define a (substring text i j))
    (define b (substring text j (+ j (- j i))))
    (when (string=? a b)
      (set-add! seen a)))
  (set-count seen))