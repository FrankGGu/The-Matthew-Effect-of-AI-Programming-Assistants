(struct TreeNode (val left right) #:mutable)

(define (create-binary-tree-from-descriptions descriptions)
  (define nodes (make-hash))
  (define children (make-hash))

  (for-each
   (lambda (desc)
     (define parent-val (car desc))
     (define child-val (cadr desc))
     (define is-left (caddr desc))

     (define parent-node
       (hash-ref! nodes parent-val
                  (lambda () (TreeNode parent-val #f #f))))

     (define child-node
       (hash-ref! nodes child-val
                  (lambda () (TreeNode child-val #f #f))))

     (hash-set! children child-val #t)

     (if (= is-left 1)
         (set-TreeNode-left! parent-node child-node)
         (set-TreeNode-right! parent-node child-node)))
   descriptions)

  (define root-val #f)
  (for-each
   (lambda (val node)
     (when (not (hash-has-key? children val))
       (set! root-val val)))
   nodes)

  (hash-ref nodes root-val))