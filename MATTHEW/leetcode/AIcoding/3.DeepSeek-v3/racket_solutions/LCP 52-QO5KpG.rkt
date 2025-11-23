(define/contract (count-nodes root ops)
  (-> (or/c #f (is-a?/c tree-node%)) (listof (listof exact-integer?)) exact-integer?)
  (define (tree-node-val node)
    (if (false? node) 0 (get-field val node)))
  (define (tree-node-left node)
    (if (false? node) #f (get-field left node)))
  (define (tree-node-right node)
    (if (false? node) #f (get-field right node)))

  (define nodes (make-hash))

  (define (inorder node)
    (when node
      (inorder (tree-node-left node))
      (hash-set! nodes (tree-node-val node) #f)
      (inorder (tree-node-right node))))

  (inorder root)

  (for ([op ops])
    (let ([t (first op)]
          [x (second op)])
      (for ([(k v) (in-hash nodes)])
        (when (<= x k)
          (hash-set! nodes k (or v (= t 1)))))))

  (for/sum ([(k v) (in-hash nodes)] #:when v) 1))