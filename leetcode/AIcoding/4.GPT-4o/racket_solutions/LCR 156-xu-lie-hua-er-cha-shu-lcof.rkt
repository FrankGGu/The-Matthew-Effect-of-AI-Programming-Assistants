#lang racket

(define TreeNode
  (struct TreeNode (val left right)))

(define (serialize root)
  (define (s n)
    (if (null? n)
        "#"
        (string-append (number->string (TreeNode-val n)) "," (s (TreeNode-left n)) "," (s (TreeNode-right n)))))
  (s root))

(define (deserialize data)
  (define (d lst)
    (if (string=? (car lst) "#")
        (begin (set! lst (cdr lst)) #f)
        (let ((node (TreeNode (string->number (car lst)) #f #f)))
          (set! lst (cdr lst))
          (set! (TreeNode-left node) (d lst))
          (set! (TreeNode-right node) (d lst))
          node)))
  (d (string-split data ",")))

(define Codec
  (struct Codec ()
    #:methods gen:serialize (serialize)
    #:methods gen:deserialize (deserialize)))