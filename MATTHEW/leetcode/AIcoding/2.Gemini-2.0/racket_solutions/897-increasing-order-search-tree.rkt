(define (increasingBST root)
  (letrec ((inorder (lambda (node acc)
                      (if (null? node)
                          acc
                          (inorder (node-right node) (cons node (inorder (node-left node) acc)))))))
           (build-tree (lambda (nodes)
                         (if (null? nodes)
                             null
                             (let ((node (car nodes)))
                               (set-node-left! node null)
                               (set-node-right! node (build-tree (cdr nodes)))
                               node)))))
    (build-tree (reverse (inorder root '())))))