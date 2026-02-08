(struct TreeNode (val left right))

(define (subtreeWithAllDeepest root)
  (define (dfs node depth)
    (if (null? node)
        (values 0 #f)
        (let-values (((left-depth left-node) (dfs (TreeNode-left node) (+ depth 1)))
                     ((right-depth right-node) (dfs (TreeNode-right node) (+ depth 1))))
          (cond
            ((> left-depth right-depth) (values left-depth left-node))
            ((< left-depth right-depth) (values right-depth right-node))
            (else (values left-depth node)))))
  (cdr (dfs root 0)))