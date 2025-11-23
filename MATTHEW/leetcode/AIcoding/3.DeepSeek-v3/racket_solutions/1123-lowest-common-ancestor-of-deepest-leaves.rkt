#lang racket

(define (lca-deepest-leaves root)
  (define (helper node)
    (if (null? node)
        (cons null 0)
        (let* ([left (helper (car (cdr node)))]
               [right (helper (car (cdr (cdr node))))]
               [left-depth (cdr left)]
               [right-depth (cdr right)]
               [current-depth (max left-depth right-depth)])
          (cond
            [(> left-depth right-depth) (cons (car left) (add1 left-depth))]
            [(< left-depth right-depth) (cons (car right) (add1 right-depth))]
            [else (cons node (add1 left-depth))]))))
  (car (helper root)))