(struct TreeNode (val left right))

(define (levelOrder root)
  (if (null? root)
      '()
      (let loop ((current-level (list root))
                 (result '()))
        (if (empty? current-level)
            (reverse result)
            (let-values (((current-level-vals next-level-nodes)
                          (for/fold ((vals '()) (next-q '()))
                                    ((node current-level))
                            (values (cons (TreeNode-val node) vals)
                                    (append next-q
                                            (if (TreeNode-left node) (list (TreeNode-left node)) '())
                                            (if (TreeNode-right node) (list (TreeNode-right node)) '()))))))
              (loop next-level-nodes
                    (cons (reverse current-level-vals) result)))))))