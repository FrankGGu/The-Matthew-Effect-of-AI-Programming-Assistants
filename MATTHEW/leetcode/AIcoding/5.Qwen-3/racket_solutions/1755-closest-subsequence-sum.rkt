#lang racket

(define (closest-subsequence-sum nums target)
  (define (dfs index current sum)
    (if (>= index (length nums))
        (abs (- sum target))
        (min (dfs (+ index 1) current (+ sum (list-ref nums index)))
             (dfs (+ index 1) current current))))
  (dfs 0 0 0))