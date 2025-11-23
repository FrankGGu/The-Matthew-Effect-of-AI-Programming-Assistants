#lang racket

(define/contract (smallest-equal nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [nums nums] [min-index #f])
    (cond
      [(null? nums) (if min-index min-index -1)]
      [else
       (if (and (not min-index) (= (car nums) i))
           (loop (+ i 1) (cdr nums) i)
           (if (and min-index (= (car nums) i))
               (loop (+ i 1) (cdr nums) (min min-index i))
               (loop (+ i 1) (cdr nums) min-index)))])))