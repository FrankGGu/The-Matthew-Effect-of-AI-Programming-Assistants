(define (balanceBST root)
  (define (inorder-traversal root acc)
    (if (null? root)
        acc
        (inorder-traversal (node-left root) (cons (node-val root) (inorder-traversal (node-right root) acc)))))

  (define (build-bst sorted-list)
    (if (null? sorted-list)
        null
        (let* ([mid (quotient (length sorted-list) 2)]
               [left-list (take sorted-list mid)]
               [right-list (drop sorted-list (+ mid 1))])
          (make-node (list-ref sorted-list mid) (build-bst left-list) (build-bst right-list)))))

  (let* ([inorder-list (reverse (inorder-traversal root '()))]
         [balanced-root (build-bst inorder-list)])
    balanced-root))