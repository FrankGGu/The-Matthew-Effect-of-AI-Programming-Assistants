(define-struct (TreeNode val left right))

(define (balanceBST root)
  (define (inorder-to-list node)
    (define (traverse current-node acc)
      (if (null? current-node)
          acc
          (traverse (TreeNode-right current-node)
                    (cons (TreeNode-val current-node)
                          (traverse (TreeNode-left current-node) acc)))))
    (reverse (traverse node '())))

  (define (build-balanced-bst sorted-list start end)
    (if (> start end)
        null
        (let* ((mid (+ start (quotient (- end start) 2)))
               (val (list-ref sorted-list mid)))
          (TreeNode val
                    (build-balanced-bst sorted-list start (- mid 1))
                    (build-balanced-bst sorted-list (+ mid 1) end)))))

  (let ((sorted-values (inorder-to-list root)))
    (build-balanced-bst sorted-values 0 (- (length sorted-values) 1))))