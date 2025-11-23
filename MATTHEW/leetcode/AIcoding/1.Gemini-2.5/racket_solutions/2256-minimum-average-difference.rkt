#lang racket

(define (minimum-average-difference nums)
  (define n (vector-length nums))

  (define total-sum
    (for/sum ([i (in-range n)])
      (vector-ref nums i)))

  (define min-avg-diff (add1 total-sum))
  (define result-index 0)
  (define current-left-sum 0)

  (for ([i (in-range n)])
    (set! current-left-sum (+ current-left-sum (vector-ref nums i)))

    (define left-avg (quotient current-left-sum (add1 i)))

    (define right-sum (- total-sum current-left-sum))
    (define right-count (- n (add1 i)))

    (define right-avg
      (if (= right-count 0)
          0
          (quotient right-sum right-count)))

    (define current-diff (abs (- left-avg right-avg)))

    (when (< current-diff min-avg-diff)
      (set! min-avg-diff current-diff)
      (set! result-index i)))

  result-index)