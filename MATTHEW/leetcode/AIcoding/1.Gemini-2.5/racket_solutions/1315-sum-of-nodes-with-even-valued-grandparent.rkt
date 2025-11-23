(struct TreeNode (val left right))

(define (sum-even-grandparent root)
  (define (dfs node parent-val grandparent-val)
    (if (null? node)
        0
        (+ (if (and (not (eq? grandparent-val -1)) ; Check if grandparent exists (not initial dummy value)
                     (even? grandparent-val))
               (TreeNode-val node)
               0)
           (dfs (TreeNode-left node) (TreeNode-val node) parent-val)
           (dfs (TreeNode-right node) (TreeNode-val node) parent-val))))
  (dfs root -1 -1)) ; Use -1 as a dummy value for non-existent parent/grandparent