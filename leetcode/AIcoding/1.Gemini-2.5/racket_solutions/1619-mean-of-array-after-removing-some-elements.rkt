#lang racket

(define (trim-mean arr)
  (let* ([n (length arr)]
         [k (floor (* 0.05 n))]
         [sorted-arr (sort arr <)]
         [sub-arr (sublist sorted-arr k (- n k))]
         [total-sum (apply + sub-arr)]
         [remaining-count (length sub-arr)])
    (/ (exact->inexact total-sum) remaining-count)))