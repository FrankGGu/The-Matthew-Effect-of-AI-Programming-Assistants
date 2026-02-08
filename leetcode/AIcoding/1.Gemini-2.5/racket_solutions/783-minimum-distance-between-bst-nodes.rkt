(struct TreeNode (val left right))

(define (min-diff-in-bst root)
  (let ([min-diff (add1 (expt 10 9))] ; Initialize with a value larger than any possible difference
        [prev-val #f]) ; Use #f to indicate no previous value encountered yet

    (define (inorder node)
      (when node
        (inorder (TreeNode-left node))

        (when prev-val
          (set! min-diff (min min-diff (- (TreeNode-val node) prev-val))))

        (set! prev-val (TreeNode-val node))

        (inorder (TreeNode-right node))))

    (inorder root)
    min-diff))