#lang racket

(define/contract (max-adjacent-difference nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ((n (length nums)))
    (if (= n 1)
        0
        (let ((min-val (apply min nums))
              (max-val (apply max nums)))
          (- max-val min-val)))))