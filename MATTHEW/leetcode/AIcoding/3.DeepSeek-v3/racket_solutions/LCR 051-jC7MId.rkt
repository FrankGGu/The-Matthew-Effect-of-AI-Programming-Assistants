#lang racket

(define (max-path-sum root)
  (define max-sum -inf.0)

  (define (helper node)
    (if (null? node)
        0
        (let* ([left (max (helper (node-left node)) 0)]
               [right (max (helper (node-right node)) 0)]
               [current (+ (node-val node) left right)])
          (set! max-sum (max max-sum current))
          (+ (node-val node) (max left right)))))

  (helper root)
  max-sum)

(define-struct node (val left right) #:transparent)