#lang racket

(define (sum-distinct-squares nums-list)
  (define nums (list->vector nums-list))
  (define n (vector-length nums))
  (define total-sum 0)

  (for ([i (in-range n)])
    (define distinct-elements (set))

    (for ([j (in-range i n)])
      (set! distinct-elements (set-add distinct-elements (vector-ref nums j)))
      (define distinct-count (set-count distinct-elements))
      (set! total-sum (+ total-sum (* distinct-count distinct-count)))
      ))
  total-sum)