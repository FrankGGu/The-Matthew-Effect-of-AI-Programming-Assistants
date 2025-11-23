#lang racket

(define (sum-digit-differences nums)
  (define n (length nums))
  (define res 0)
  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (define a (list-ref nums i))
      (define b (list-ref nums j))
      (define diff (for/sum ([x (in-list a)] [y (in-list b)]) (abs (- x y))))
      (set! res (+ res diff))))
  res)