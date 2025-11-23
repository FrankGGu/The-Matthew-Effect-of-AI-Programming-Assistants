(require racket/list)

(struct TreeNode (val left right) #:transparent)

(define (build-tree preorder inorder)
  (cond
    [(empty? preorder) #f]
    [else
     (define root-val (first preorder))

     (define root-idx (position (lambda (x) (= x root-val)) inorder))

     (define left-inorder (take inorder root-idx))
     (define right-inorder (drop inorder (+ root-idx 1)))

     (define left-subtree-size (length left-inorder))

     (define left-preorder (take (rest preorder) left-subtree-size))
     (define right-preorder (drop (rest preorder) left-subtree-size))

     (TreeNode root-val
               (build-tree left-preorder left-inorder)
               (build-tree right-preorder right-inorder))]))