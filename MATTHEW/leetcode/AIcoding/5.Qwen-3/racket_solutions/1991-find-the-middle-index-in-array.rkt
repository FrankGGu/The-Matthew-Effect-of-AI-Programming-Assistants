#lang racket

(define/contract (middle-index nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [left 0] [right (apply + (cdr nums))])
    (if (= left right) i
        (if (< i (sub1 (length nums)))
            (loop (add1 i) (+ left (list-ref nums i)) (- right (list-ref nums (add1 i))))
            -1))))