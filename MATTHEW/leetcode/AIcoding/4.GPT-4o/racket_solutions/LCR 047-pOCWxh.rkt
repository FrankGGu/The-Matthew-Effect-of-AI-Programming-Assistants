(define (pruneTree root)
  (define (containsOne node)
    (if (null? node)
        #f
        (let ((left (containsOne (tree-left node)))
              (right (containsOne (tree-right node))))
          (if (or (= (tree-val node) 1) left right)
              (begin
                (set-tree-left! node (if left (tree-left node) #f))
                (set-tree-right! node (if right (tree-right node) #f))
                #t)
              #f))))
  (if (containsOne root)
      root
      #f))