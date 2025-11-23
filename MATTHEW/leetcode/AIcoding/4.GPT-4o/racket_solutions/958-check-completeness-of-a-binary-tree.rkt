(define (isCompleteBinaryTree root)
  (define (helper node index totalNodes)
    (if (null? node)
      #t
      (and (<= index totalNodes)
           (helper (node-left node) (* 2 index))
           (helper (node-right node) (+ 1 (* 2 index))))))
  (define (countNodes node)
    (if (null? node)
      0
      (+ 1 (countNodes (node-left node)) (countNodes (node-right node)))))
  (let ((totalNodes (countNodes root)))
    (helper root 1 totalNodes)))

(define (isCompleteBinaryTreeWrapper root)
  (isCompleteBinaryTree root))