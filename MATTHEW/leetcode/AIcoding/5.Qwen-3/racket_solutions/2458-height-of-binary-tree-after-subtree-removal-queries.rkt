#lang racket

(define (make-tree-node val left right)
  (vector val left right))

(define (tree-node-val node) (vector-ref node 0))
(define (tree-node-left node) (vector-ref node 1))
(define (tree-node-right node) (vector-ref node 2))

(define (height root)
  (cond [(not root) 0]
        [else (add1 (max (height (tree-node-left root)) (height (tree-node-right root))))]))

(define (get-queries-heights root queries)
  (define (build-height-map node)
    (if (not node)
        '()
        (let* ([left (tree-node-left node)]
               [right (tree-node-right node)]
               [left-height (height left)]
               [right-height (height right)]
               [current-height (add1 (max left-height right-height))]
               [left-map (build-height-map left)]
               [right-map (build-height-map right)])
          (append (list (cons (tree-node-val node) current-height)) left-map right-map))))

  (define height-map (build-height-map root))

  (define (get-height val)
    (cdr (assoc val height-map)))

  (map get-height queries))