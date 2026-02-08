(define-struct TreeNode (val left right))

(define (max-product-split-binary-tree root)
  (define (tree-sum node)
    (if (null? node)
        0
        (+ (TreeNode-val node) (tree-sum (TreeNode-left node)) (tree-sum (TreeNode-right node)))))

  (define total-sum (tree-sum root))
  (define max-product 0)

  (define (dfs node)
    (if (null? node)
        0
        (let* ((left-sum (dfs (TreeNode-left node)))
               (right-sum (dfs (TreeNode-right node)))
               (current-sum (+ left-sum right-sum (TreeNode-val node)))
               (product (* current-sum (- total-sum current-sum))))
          (set! max-product (max max-product product))
          current-sum)))

  (dfs root)
  max-product)