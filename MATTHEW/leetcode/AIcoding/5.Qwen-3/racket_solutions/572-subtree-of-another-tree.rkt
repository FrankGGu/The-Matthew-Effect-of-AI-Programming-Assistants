#lang racket

(define (is-subtree root sub-root)
  (define (equal? t1 t2)
    (cond [(and (not t1) (not t2)) #t]
          [(or (not t1) (not t2)) #f]
          [else (and (= (tree-node-val t1) (tree-node-val t2))
                     (equal? (tree-node-left t1) (tree-node-left t2))
                     (equal? (tree-node-right t1) (tree-node-right t2)))]))

  (define (traverse node)
    (or (equal? node sub-root)
        (and (not (tree-node-left node)) (not (tree-node-right node)) #f)
        (or (traverse (tree-node-left node))
            (traverse (tree-node-right node)))))

  (traverse root))