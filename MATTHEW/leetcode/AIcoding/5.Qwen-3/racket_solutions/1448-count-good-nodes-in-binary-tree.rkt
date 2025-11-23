#lang racket

(define (count-good-nodes root)
  (define (helper node max-so-far)
    (if (not node)
        0
        (+ (if (>= (node-val node) max-so-far) 1 0)
           (helper (node-left node) (max max-so-far (node-val node)))
           (helper (node-right node) (max max-so-far (node-val node))))))
  (helper root -inf.0))