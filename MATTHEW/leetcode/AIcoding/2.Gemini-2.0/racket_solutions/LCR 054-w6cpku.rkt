(define (convert-bst! root)
  (let ((sum 0))
    (define (inorder-reverse! node)
      (cond [(null? node) #f]
            [else
             (inorder-reverse! (bst-node-right node))
             (set! sum (+ sum (bst-node-val node)))
             (set-bst-node-val! node sum)
             (inorder-reverse! (bst-node-left node))]))
    (inorder-reverse! root)
    root))