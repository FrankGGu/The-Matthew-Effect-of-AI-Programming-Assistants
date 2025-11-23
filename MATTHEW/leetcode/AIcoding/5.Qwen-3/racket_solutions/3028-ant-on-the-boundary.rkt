#lang racket

(define/contract (ant-on-the-boundary nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [pos 0] [count 0])
    (if (null? nums)
        count
        (let* ([num (car nums)]
               [new-pos (+ pos num)])
          (loop (cdr nums) new-pos (if (= new-pos 0) (+ count 1) count))))))