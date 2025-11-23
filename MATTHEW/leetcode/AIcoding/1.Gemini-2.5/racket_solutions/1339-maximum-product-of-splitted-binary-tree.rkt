(struct TreeNode (val left right))

(define (max-product root)
  (define MOD 1000000007)

  (define (get-total-sum node)
    (if (null? node)
        0
        (+ (TreeNode-val node)
           (get-total-sum (TreeNode-left node))
           (get-total-sum (TreeNode-right node)))))

  (define total-sum (get-total-sum root))

  (define max-prod-box (box 0))

  (define (dfs node)
    (if (null? node)
        0
        (let* ((left-subtree-sum (dfs (TreeNode-left node)))
               (right-subtree-sum (dfs (TreeNode-right node)))
               (current-subtree-sum (+ (TreeNode-val node) left-subtree-sum right-subtree-sum)))
          (let ((product (* current-subtree-sum (- total-sum current-subtree-sum))))
            (when (> product (unbox max-prod-box))
              (set-box! max-prod-box product)))
          current-subtree-sum)))

  (dfs root)

  (remainder (unbox max-prod-box) MOD))