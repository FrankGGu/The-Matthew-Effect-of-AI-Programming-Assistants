#lang racket

(define (get-absolute-min root)
  (define min-diff #f)
  (define prev #f)
  (define (inorder node)
    (when node
      (inorder (node-left node))
      (when (and prev (not min-diff))
        (set! min-diff (abs (- (node-val node) (node-val prev)))))
      (set! prev node)
      (inorder (node-right node)))
    (when (and prev (not min-diff))
      (set! min-diff (abs (- (node-val prev) (node-val root))))))
  (inorder root)
  min-diff)

(define (min-absolute-difference root)
  (if (or (not root) (and (not (node-left root)) (not (node-right root))))
      0
      (get-absolute-min root)))