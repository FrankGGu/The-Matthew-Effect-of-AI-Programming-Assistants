#lang racket

(define/contract (minimum-travel-time nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [res 0])
    (if (null? (cdr nums))
        res
        (let* ([min1 (apply min nums)]
               [idx (index-of nums min1)]
               [left (if (> idx 0) (list-ref nums (- idx 1)) +inf.0)]
               [right (if (< idx (- (length nums) 1)) (list-ref nums (+ idx 1)) +inf.0)]
               [merged (if (< left right) (+ min1 left) (+ min1 right))]
               [new-nums (append (take nums (if (< left right) (- idx 1) idx))
                                 (list merged)
                                 (drop nums (if (< left right) (+ idx 1) (+ idx 2))))])
          (loop new-nums (+ res merged))))))