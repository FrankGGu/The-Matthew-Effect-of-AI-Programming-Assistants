#lang racket

(define (max-operations nums)
  (define n (length nums))
  (if (< n 2)
      0
      (let ([sum1 (+ (first nums) (second nums))]
            [sum2 (+ (first nums) (last nums))]
            [sum3 (+ (second nums) (last nums))])
        (max (helper nums sum1)
             (helper nums sum2)
             (helper nums sum3)))))

(define (helper nums target)
  (define n (length nums))
  (if (< n 2)
      0
      (let ([sum (+ (first nums) (last nums))])
        (if (= sum target)
            (+ 1 (helper (cdr (reverse (cdr (reverse nums)))) target))
            0))))