(define (cloneGraph node)
  (define visited (make-hash))

  (define (dfs v)
    (if (hash-ref visited v #f)
        (hash-ref visited v)
        (begin
          (define new-node (make-node (node-val v)))
          (hash-set! visited v new-node)
          (for-each (lambda (neighbor)
                      (set! (node-neighbors new-node) 
                            (cons (dfs neighbor) (node-neighbors new-node))))
                    (node-neighbors v))
          new-node)))

  (if (null? node)
      #f
      (dfs node)))