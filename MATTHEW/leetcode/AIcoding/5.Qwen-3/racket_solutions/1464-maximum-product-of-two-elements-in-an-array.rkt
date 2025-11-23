#lang racket

(define/contract (max-product nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted (sort nums >)]
         [a (car sorted)]
         [b (cadr sorted)])
    (* a b)))