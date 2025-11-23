#lang racket

(define (sorted-array-to-bst nums)
  (define (helper left right)
    (if (> left right)
        #f
        (let* ([mid (quotient (+ left right) 2)]
               [node (make-node (list-ref nums mid))])
          (set-node-left! node (helper left (- mid 1)))
          (set-node-right! node (helper (+ mid 1) right))
          node)))
  (helper 0 (- (length nums) 1)))

(define-struct node (val left right) #:mutable)