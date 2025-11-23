#lang racket
(define (path-sum root target)
  (define (dfs node current-sum path)
    (when node
      (set! current-sum (+ current-sum (node-val node)))
      (set! path (cons (node-val node) path))
      (if (and (null? (left node)) (null? (right node)) (equal? current-sum target))
          (cons (reverse path) '())
          (append (dfs (left node) current-sum path) (dfs (right node) current-sum path)))))
  (dfs root 0 '()))

(define (node-val node) (if node (node-value node) 0))
(define (left node) (if node (node-left node) #f))
(define (right node) (if node (node-right node) #f))