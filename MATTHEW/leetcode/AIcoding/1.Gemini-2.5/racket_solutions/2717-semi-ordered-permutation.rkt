#lang racket

(require srfi/1)

(define (semi-ordered-permutation nums)
  (let* ([n (length nums)]
         [pos1 (index-of nums 1)]
         [posN (index-of nums n)])
    (let ([swaps (+ pos1 (- (- n 1) posN))])
      (if (> pos1 posN)
          (- swaps 1)
          swaps))))