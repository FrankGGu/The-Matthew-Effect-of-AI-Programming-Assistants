#lang racket

(struct node (val neighbors) #:mutable)

(define (clone-graph node)
  (when (not node)
    #f)

  (define visited-map (make-hash-eq))

  (define (dfs-clone original-node)
    (cond [(hash-has-key? visited-map original-node)
           (hash-ref visited-map original-node)]
          [else
           (define cloned-node (node (node-val original-node) '()))
           (hash-set! visited-map original-node cloned-node)

           (define cloned-neighbors
             (map dfs-clone (node-neighbors original-node)))
           (set-node-neighbors! cloned-node cloned-neighbors)

           cloned-node]))

  (dfs-clone node))