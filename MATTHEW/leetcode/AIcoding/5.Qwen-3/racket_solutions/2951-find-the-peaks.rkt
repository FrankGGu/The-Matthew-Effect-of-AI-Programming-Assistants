#lang racket

(define/contract (find-peaks peaks)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define (is-peak i)
    (and (< i (- (length peaks) 1))
         (> (list-ref peaks i) (list-ref peaks (- i 1)))
         (> (list-ref peaks i) (list-ref peaks (+ i 1)))))
  (filter is-peak (range (length peaks))))