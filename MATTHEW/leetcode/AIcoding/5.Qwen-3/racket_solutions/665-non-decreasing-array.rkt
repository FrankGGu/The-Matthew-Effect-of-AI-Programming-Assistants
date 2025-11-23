#lang racket

(define (non-decreasing-array nums)
  (define len (length nums))
  (define-values (count i) (for/fold ([count 0] [i 0]) ([j (in-range 1 len)])
                             (if (<= (list-ref nums j) (list-ref nums (sub1 j)))
                                 (values count (add1 i))
                                 (values (add1 count) (add1 i)))))
  (if (<= count 1) #t #f))