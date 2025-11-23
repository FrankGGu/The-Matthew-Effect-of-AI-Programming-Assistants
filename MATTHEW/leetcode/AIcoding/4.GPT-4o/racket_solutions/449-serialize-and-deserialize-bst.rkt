#lang racket

(define-type TreeNode
  (struct TreeNode (val left right)))

(define (serialize root)
  (define (shelper node)
    (if (null? node)
        "#"
        (string-append (number->string (TreeNode-val node)) ","
                       (shelper (TreeNode-left node)) ","
                       (shelper (TreeNode-right node)))))
  (shelper root))

(define (deserialize data)
  (define (dhelper lst)
    (if (string=? (car lst) "#")
        (begin
          (set! lst (cdr lst))
          #f)
        (begin
          (define node (make-TreeNode (string->number (car lst)) 
                                       (dhelper (cdr lst)) 
                                       (dhelper (cdr lst))))
          node)))
  (dhelper (string-split data #\,)))

(define (serialize-deserialize-bst bst)
  (define serialized (serialize bst))
  (deserialize serialized))