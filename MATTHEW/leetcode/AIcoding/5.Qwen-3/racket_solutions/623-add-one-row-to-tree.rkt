#lang racket

(define (add-one-row root val depth)
  (if (or (null? root) (= depth 1))
      (make-node val root #f)
      (let ((new-root (make-node (node-val root) #f #f)))
        (set-node-left! new-root (add-one-row (node-left root) val (- depth 1)))
        (set-node-right! new-root (add-one-row (node-right root) val (- depth 1)))
        new-root)))

(define-struct node (val left right) #:mutable)

(define (make-node val left right)
  (let ((n (make-node val left right)))
    n))

(define (add-one-row-to-tree root val depth)
  (if (= depth 1)
      (make-node val root #f)
      (add-one-row root val depth)))