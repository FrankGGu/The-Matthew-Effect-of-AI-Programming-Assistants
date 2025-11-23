#lang racket

(define/contract (peaks nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define (is-peak i)
    (and (< 0 i) (< i (- (length nums) 1)) (> (list-ref nums i) (list-ref nums (- i 1))) (> (list-ref nums i) (list-ref nums (+ i 1)))))
  (filter is-peak (range (length nums))))