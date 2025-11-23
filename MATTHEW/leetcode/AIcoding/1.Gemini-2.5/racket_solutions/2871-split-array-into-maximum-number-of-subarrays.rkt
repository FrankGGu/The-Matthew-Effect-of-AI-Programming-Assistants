#lang racket

(define (maximum-subarrays nums)
  (let* ([n (length nums)]
         [overall-and (foldl bitwise-and (car nums) (cdr nums))]
         [has-zero? (ormap (lambda (x) (= x 0)) nums)])
    (if (or (> overall-and 0) (not has-zero?))
        n
        0)))