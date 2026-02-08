(define-struct TreeNode (val left right))

(define (range-sum-bst root low high)
  (cond
    [(null? root) 0]
    [else
     (let ((node-val (TreeNode-val root)))
       (cond
         [(< node-val low)
          (range-sum-bst (TreeNode-right root) low high)]
         [(> node-val high)
          (range-sum-bst (TreeNode-left root) low high)]
         [else
          (+ node-val
             (range-sum-bst (TreeNode-left root) low high)
             (range-sum-bst (TreeNode-right root) low high))]))]))