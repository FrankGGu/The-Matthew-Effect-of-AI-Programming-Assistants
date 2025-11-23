#lang racket

(define (min-start-value nums)
  (let loop ([sum 0] [min-sum 0] [nums nums])
    (cond [(null? nums) (max 1 (- min-sum))]
          [else (loop (+ sum (car nums)) (min min-sum (+ sum (car nums))) (cdr nums))])))