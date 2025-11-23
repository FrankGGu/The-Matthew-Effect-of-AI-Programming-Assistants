#lang racket

(define (digit-sum n)
  (define (iter num sum)
    (if (= num 0)
        sum
        (iter (quotient num 10) (+ sum (remainder num 10)))))
  (iter n 0))

(define (count-even-digit-sum n)
  (define (iter i count)
    (if (> i n)
        count
        (let ((sum (digit-sum i)))
          (if (even? sum)
              (iter (+ i 1) (+ count 1))
              (iter (+ i 1) count)))))
  (iter 0 0))