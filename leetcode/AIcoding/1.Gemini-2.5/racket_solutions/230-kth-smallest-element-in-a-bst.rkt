(struct TreeNode (val left right))

(define (kth-smallest root k)
  (define counter (box 0))
  (define result (box #f)) ; Stores the value of the kth smallest element

  (define (inorder-traverse node)
    ;; Only proceed if the current node exists and the result has not been found yet
    (when (and node (eq? (unbox result) #f))
      ;; Traverse left subtree
      (inorder-traverse (TreeNode-left node))

      ;; After left subtree, process current node if result not found
      (when (eq? (unbox result) #f)
        (set-box! counter (+ (unbox counter) 1))
        (when (= (unbox counter) k)
          (set-box! result (TreeNode-val node))))

      ;; Traverse right subtree if result not found after current node
      (when (eq? (unbox result) #f)
        (inorder-traverse (TreeNode-right node)))))

  (inorder-traverse root)
  (unbox result))