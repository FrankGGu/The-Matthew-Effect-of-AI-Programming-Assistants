(define (balance-bst root)
  (define (inorder-traversal node)
    (if (null? node)
        '()
        (append (inorder-traversal (left node))
                (list (val node))
                (inorder-traversal (right node)))))

  (define (sorted-array-to-bst arr)
    (if (null? arr)
        '()
        (let* ([mid (quotient (length arr) 2)]
               [node (make-node (list-ref arr mid))])
          (set-left! node (sorted-array-to-bst (sublist arr 0 mid)))
          (set-right! node (sorted-array-to-bst (sublist arr (add1 mid) (length arr))))
          node)))

  (sorted-array-to-bst (inorder-traversal root)))