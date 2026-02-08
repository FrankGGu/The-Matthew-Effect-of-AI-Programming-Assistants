(struct TreeNode (val left right))

(define (subtree-inversion-sum root)
  (define total-sum-of-all-subtree-sums 0)

  (define (dfs node)
    (if (not node)
        0
        (let* ([left-sum (dfs (TreeNode-left node))]
               [right-sum (dfs (TreeNode-right node))]
               [current-subtree-sum (+ (TreeNode-val node) left-sum right-sum)])
          (set! total-sum-of-all-subtree-sums (+ total-sum-of-all-subtree-sums current-subtree-sum))
          current-subtree-sum)))

  (dfs root)
  total-sum-of-all-subtree-sums)