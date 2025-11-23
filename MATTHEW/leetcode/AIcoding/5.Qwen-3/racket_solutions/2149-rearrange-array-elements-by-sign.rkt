#lang racket

(define/contract (rearrange-by-sign nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let loop ([pos '()] [neg '()] [nums nums])
    (cond
      [(null? nums) (append pos neg)]
      [(positive? (car nums)) (loop (cons (car nums) pos) neg (cdr nums))]
      [else (loop pos (cons (car nums) neg) (cdr nums))])))