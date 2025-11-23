(struct TreeNode (val left right))

(define (buildTree inorder postorder)
  (define inorder-map (make-hash))
  (for ([val (in-list inorder)] [idx (in-naturals)])
    (hash-set! inorder-map val idx))

  (define (build in-start in-end post-start post-end)
    (if (>= in-start in-end)
        null
        (let* ([root-val (list-ref postorder (- post-end 1))]
               [root-idx-in-inorder (hash-ref inorder-map root-val)]
               [left-subtree-size (- root-idx-in-inorder in-start)]
               [left-child (build in-start
                                  root-idx-in-inorder
                                  post-start
                                  (+ post-start left-subtree-size))]
               [right-child (build (+ root-idx-in-inorder 1)
                                   in-end
                                   (+ post-start left-subtree-size)
                                   (- post-end 1))])
          (TreeNode root-val left-child right-child))))

  (build 0 (length inorder) 0 (length postorder)))