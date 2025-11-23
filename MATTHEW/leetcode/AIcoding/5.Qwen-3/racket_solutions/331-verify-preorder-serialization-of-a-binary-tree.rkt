#lang racket

(define (verify-preorder-serialization preorder)
  (define nodes (string-split preorder ","))
  (define (helper index)
    (cond [(>= index (length nodes)) #t]
          [else
           (let ([left (helper (+ index 1))])
             (if left
                 (helper (+ index 2))
                 #f))]))
  (helper 0))