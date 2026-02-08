#lang racket

(define (min-depth root)
  (cond
    [(null? root) 0]
    [(and (null? (node-left root)) (null? (node-right root))) 1]
    [(null? (node-left root)) (+ 1 (min-depth (node-right root)))]
    [(null? (node-right root)) (+ 1 (min-depth (node-left root)))]
    [else (+ 1 (min (min-depth (node-left root)) (min-depth (node-right root))))]))

(struct node
  (val left right) #:mutable #:transparent)

(define (make-node [val 0] [left null] [right null])
  (node val left right))