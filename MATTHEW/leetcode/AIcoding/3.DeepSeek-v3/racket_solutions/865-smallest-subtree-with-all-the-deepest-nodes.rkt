(define/contract (subtree-with-all-deepest root)
  (-> (or/c #f tree-node?) (or/c #f tree-node?))
  (define (max-depth node)
    (if (not node) 0
        (+ 1 (max (max-depth (tree-node-left node))
                  (max-depth (tree-node-right node))))))
  (define (helper node depth max-d)
    (cond
      [(not node) #f]
      [(= depth max-d) node]
      [else
       (let ([left (helper (tree-node-left node) (+ 1 depth) max-d)]
             [right (helper (tree-node-right node) (+ 1 depth) max-d)])
         (cond
           [(and left right) node]
           [left left]
           [right right]
           [else #f]))]))
  (if (not root) #f
      (let ([max-d (max-depth root)])
        (helper root 1 max-d))))

(define tree-node?
  (letrec ([struct-tree-node
            (lambda (val left right)
              (vector 'tree-node val left right))]
           [tree-node?
            (lambda (x)
              (and (vector? x)
                   (= (vector-length x) 4)
                   (eq? (vector-ref x 0) 'tree-node)))])
    struct-tree-node))