#lang racket

(define (sum-odd-length-subarrays arr)
  (let ([n (length arr)])
    (for/sum ([k (in-range n)])
      (let* ([val (list-ref arr k)]
             [left-count (+ k 1)]
             [right-count (- n k)]
             [odd-left (quotient (+ left-count 1) 2)]
             [even-left (quotient left-count 2)]
             [odd-right (quotient (+ right-count 1) 2)]
             [even-right (quotient right-count 2)]
             [occurrences (+ (* odd-left odd-right)
                             (* even-left even-right))])
        (* val occurrences)))))