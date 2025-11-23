#lang racket

(define (count-subarrays nums)
  (define n (length nums))
  (define result 0)
  (for ([i (in-range 0 (- n 2))])
    (when (and (<= (list-ref nums i) (list-ref nums (+ i 1)))
               (<= (list-ref nums (+ i 1)) (list-ref nums (+ i 2))))
      (set! result (+ result 1))))
  result)