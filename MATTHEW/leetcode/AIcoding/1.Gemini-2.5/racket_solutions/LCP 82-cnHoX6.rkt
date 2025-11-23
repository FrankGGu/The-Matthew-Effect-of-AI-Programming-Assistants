(struct TreeNode (val left right))

(define max-global-sum -inf.0)

(define (dfs-max-path-sum node)
  (if (not node)
      0
      (let* ((left-gain (max 0 (dfs-max-path-sum (TreeNode-left node))))
             (right-gain (max 0 (dfs-max-path-sum (TreeNode-right node))))
             (current-path-sum (+ (TreeNode-val node) left-gain right-gain)))
        (set! max-global-sum (max max-global-sum current-path-sum))
        (+ (TreeNode-val node) (max left-gain right-gain))))))

(define (max-path-sum root)
  (set! max-global-sum -inf.0)
  (dfs-max-path-sum root)
  max-global-sum)