#lang racket

(define (serialize root)
  (define lst '())
  (define (helper node)
    (if (null? node)
        (set! lst (cons "null" lst))
        (begin
          (set! lst (cons (number->string (node-val node)) lst))
          (helper (node-left node))
          (helper (node-right node)))))
  (helper root)
  (string-join (reverse lst) ","))

(define (deserialize data)
  (define lst (string-split data ","))
  (define (helper)
    (if (null? lst)
        null
        (let ([val (car lst)])
          (set! lst (cdr lst))
          (if (string=? val "null")
              null
              (let ([node (make-node (string->number val) null null)])
                (set-node-left! node (helper))
                (set-node-right! node (helper))
                node)))))
  (helper))

(define-struct node (val left right) #:mutable #:transparent)