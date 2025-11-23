#lang racket

(define (ways-to-buy-pens-pencils total cost1 cost2)
  (define max-pens (quotient total cost1))
  (for/sum ([pens (in-range 0 (add1 max-pens))])
    (define remaining (- total (* pens cost1)))
    (add1 (quotient remaining cost2))))