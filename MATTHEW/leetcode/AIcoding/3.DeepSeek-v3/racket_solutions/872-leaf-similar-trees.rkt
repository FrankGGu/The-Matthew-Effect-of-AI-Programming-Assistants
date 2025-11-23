#lang racket

(define (leaf-similar? root1 root2)
  (define (get-leaves root)
    (let loop ([node root] [leaves '()])
      (cond
        [(null? node) leaves]
        [(and (null? (left node)) (null? (right node)))
         (cons (val node) leaves)]
        [else
         (append (loop (right node) leaves)
                 (loop (left node) leaves))])))
  (equal? (get-leaves root1) (get-leaves root2)))

(define (val node) (vector-ref node 0))
(define (left node) (vector-ref node 1))
(define (right node) (vector-ref node 2))