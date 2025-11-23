#lang racket

(define/struct node (val next))

(define (has-cycle? head)
  (define (helper slow fast)
    (cond [(or (not slow) (not fast)) #f]
          [(eq? slow fast) #t]
          [else (helper (node-next slow) (node-next (node-next fast)))]))
  (helper head head))