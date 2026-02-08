#lang racket

(define (build-array nums)
  (for/list ([i (in-range (length nums))])
    (list-ref nums (list-ref nums i))))