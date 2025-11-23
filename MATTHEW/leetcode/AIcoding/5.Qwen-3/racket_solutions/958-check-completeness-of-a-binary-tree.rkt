#lang racket

(define (is-complete-tree root)
  (define (helper queue)
    (cond [(null? queue) #t]
          [(null? (car queue)) #f]
          [else
           (let ([node (car queue)])
             (if (and (null? (node-left node)) (null? (node-right node)))
                 (helper (cdr queue))
                 (helper (append (filter (lambda (x) (not (null? x))) (list (node-left node) (node-right node))) (cdr queue))))])))
  (helper (list root)))

(define-struct node (val left right) #:mutable)