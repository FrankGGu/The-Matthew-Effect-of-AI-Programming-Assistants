#lang racket

(define (range-sum-bst root low high)
  (cond
    [(null? root) 0]
    [(> (node-value root) high) (range-sum-bst (left-child root) low high)]
    [(< (node-value root) low) (range-sum-bst (right-child root) low high)]
    [else (+ (node-value root)
             (range-sum-bst (left-child root) low high)
             (range-sum-bst (right-child root) low high))]))

(define (node-value node) (if node (node-value-impl node) 0))
(define (left-child node) (if node (left-child-impl node) #f))
(define (right-child node) (if node (right-child-impl node) #f))