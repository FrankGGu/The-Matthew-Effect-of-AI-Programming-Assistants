#lang racket

(define/contract (shuffle nums n)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (define (helper i res)
    (if (>= i n)
        res
        (helper (+ i 1) (append res (list (list-ref nums i) (list-ref nums (+ i n)))))))
  (flatten (helper 0 '())))