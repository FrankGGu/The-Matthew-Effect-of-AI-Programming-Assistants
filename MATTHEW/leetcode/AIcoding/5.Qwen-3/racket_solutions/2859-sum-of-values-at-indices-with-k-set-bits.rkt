#lang racket

(define/contract (sum-indices-with-k-set-bits nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (count-set-bits n)
    (if (= n 0)
        0
        (+ (remainder n 2) (count-set-bits (quotient n 2)))))
  (define (helper lst idx acc)
    (cond [(null? lst) acc]
          [else (helper (cdr lst) (+ idx 1) (if (= (count-set-bits idx) k) (+ acc (car lst)) acc))]))
  (helper nums 0 0))