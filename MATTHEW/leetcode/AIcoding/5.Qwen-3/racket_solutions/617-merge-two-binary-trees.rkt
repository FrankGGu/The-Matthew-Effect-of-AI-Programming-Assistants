#lang racket

(define (merge-trees t1 t2)
  (cond [(not t1) t2]
        [(not t2) t1]
        [else (set-node-value (node-value t1) (merge-trees (node-left t1) (merge-trees (node-right t1) (node-right t2))))]))