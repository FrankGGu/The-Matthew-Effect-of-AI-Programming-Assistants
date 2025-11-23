#lang racket

(define (serialize root)
  (define (helper node)
    (if (not node)
        (list "null")
        (append (list (number->string (node-val node)))
                (helper (node-left node))
                (helper (node-right node)))))
  (string-join (map (lambda (x) (if (equal? x "null") "null" x)) (helper root)) ","))

(define (deserialize data)
  (define lst (string-split data ","))
  (define (helper)
    (if (equal? (car lst) "null")
        #f
        (let ((val (string->number (car lst))))
          (set! lst (cdr lst))
          (make-node val (helper) (helper)))))
  (helper))

(define (make-node val left right)
  (vector val left right))

(define (node-val node)
  (vector-ref node 0))

(define (node-left node)
  (vector-ref node 1))

(define (node-right node)
  (vector-ref node 2))