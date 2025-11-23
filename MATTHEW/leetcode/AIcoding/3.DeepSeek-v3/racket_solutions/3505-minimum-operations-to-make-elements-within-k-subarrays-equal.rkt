#lang racket

(define/contract (min-operations nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums nums] [count 0])
    (cond
      [(empty? nums) count]
      [(= (car nums) k) (loop (cdr nums) count)]
      [else (loop (cdr nums) (add1 count))])))