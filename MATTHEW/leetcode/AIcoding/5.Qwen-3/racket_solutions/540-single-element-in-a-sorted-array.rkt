#lang racket

(define/contract (single-non-overlapping-element nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right (sub1 (length nums))])
    (if (= left right)
        (list-ref nums left)
        (let* ([mid (quotient (+ left right) 2)]
               [is_even (even? mid)])
          (if (and is_even (= (list-ref nums mid) (list-ref nums (add1 mid))))
              (loop (add1 mid) right)
              (loop left mid))))))