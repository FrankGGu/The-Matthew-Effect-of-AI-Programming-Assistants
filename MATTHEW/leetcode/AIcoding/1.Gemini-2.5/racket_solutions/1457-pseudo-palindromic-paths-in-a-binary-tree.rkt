(struct TreeNode (val left right))

(define (pseudo-palindromic-paths root)
  (define (dfs node mask)
    (if (null? node)
        0
        (let ([new-mask (bitwise-xor mask (bitwise-lshift 1 (TreeNode-val node)))])
          (if (and (null? (TreeNode-left node)) (null? (TreeNode-right node))) ; It's a leaf node
              (if (<= (bitwise-popcount new-mask) 1) 1 0) ; Check if the path is pseudo-palindromic
              (+ (dfs (TreeNode-left node) new-mask)
                 (dfs (TreeNode-right node) new-mask))))))
  (dfs root 0))