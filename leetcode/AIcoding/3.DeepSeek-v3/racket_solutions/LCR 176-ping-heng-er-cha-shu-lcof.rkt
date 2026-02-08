(define/contract (is-balanced root)
  (-> (or/c #f tree-node?) boolean?)
  (define (height node)
    (if (not node)
        0
        (+ 1 (max (height (tree-node-left node)) (height (tree-node-right node))))))
  (define (check node)
    (if (not node)
        #t
        (and (check (tree-node-left node))
             (check (tree-node-right node))
             (<= (abs (- (height (tree-node-left node)) (height (tree-node-right node))) 1))))
  (check root))