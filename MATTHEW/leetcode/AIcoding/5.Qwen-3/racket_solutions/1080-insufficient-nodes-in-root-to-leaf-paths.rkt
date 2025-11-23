#lang racket

(define (insufficient-nodes root)
  (define (dfs node depth)
    (cond [(not node) #f]
          [(and (not (car node)) (not (cadr node))) (if (< depth 2) #f #t)]
          [else
           (define left (dfs (cadr node) (+ depth 1)))
           (define right (dfs (caddr node) (+ depth 1)))
           (when (not left) (set! (cadr node) #f))
           (when (not right) (set! (caddr node) #f))
           (or left right)]))
  (dfs root 1)
  root)