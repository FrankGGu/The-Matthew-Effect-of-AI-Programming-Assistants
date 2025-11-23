#lang racket

(define (deleteNodes head to_delete)
  (define to-delete-set (set to_delete))
  (define (helper node)
    (when node
      (if (set-member? to-delete-set (node-value node))
          (helper (node-next node))
          (begin
            (set-next! node (helper (node-next node)))
            node))))
  (helper head))

(define (set-next! node next-node)
  (set! (node-next node) next-node))

(define (node-value node) (car node))
(define (node-next node) (cadr node))
(define (set-node-value! node value) (set-car! node value))
(define (set-node-next! node next) (set-cdr! node next))