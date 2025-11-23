(define-struct node (name children alive?))

(define throne-inheritance%
  (class object%
    (super-new)

    (init-field kingName)

    (define root (make-node kingName '() #t))
    (define name-to-node (make-hash))

    (hash-set! name-to-node kingName root)

    (define/public (birth parentName childName)
      (define parent-node (hash-ref name-to-node parentName))
      (define child-node (make-node childName '() #t))
      (set-node-children! parent-node (cons child-node (node-children parent-node)))
      (hash-set! name-to-node childName child-node))

    (define/public (death name)
      (define node (hash-ref name-to-node name))
      (set-node-alive?! node #f))

    (define/public (getInheritanceOrder)
      (define result '())
      (define (dfs node)
        (when (node-alive? node)
          (set! result (cons (node-name node) result)))
        (for ([child (in-list (node-children node))])
          (dfs child)))
      (dfs root)
      (reverse result))))