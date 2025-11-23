#lang racket

(define-struct node (val next random) #:mutable)

(define (copy-random-list head)
  (define (get-node node-map node)
    (if (not node) #f (hash-ref node-map node #f)))

  (define node-map (make-hash))
  (define new-head #f)
  (define new-tail #f)

  (let loop ([node head])
    (when node
      (hash-set! node-map node (make-node (node-val node) #f #f))
      (loop (node-next node))))

  (let loop ([node head])
    (when node
      (define new-node (hash-ref node-map node))
      (set-node-next! new-node (get-node node-map (node-next node)))
      (set-node-random! new-node (get-node node-map (node-random node)))
      (loop (node-next node))))

  (hash-ref node-map head))