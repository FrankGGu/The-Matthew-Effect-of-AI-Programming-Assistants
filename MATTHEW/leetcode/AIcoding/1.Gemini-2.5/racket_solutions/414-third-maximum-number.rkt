#lang racket

(define (third-max nums)
  (let* ([distinct-nums (sort (remove-duplicates nums) >)]
         [len (length distinct-nums)])
    (if (>= len 3)
        (list-ref distinct-nums 2)
        (car distinct-nums))))