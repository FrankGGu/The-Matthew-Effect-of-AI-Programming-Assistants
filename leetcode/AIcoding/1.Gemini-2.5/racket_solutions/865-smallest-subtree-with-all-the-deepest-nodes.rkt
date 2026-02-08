(define (subtree-with-all-deepest root)
  (define (find-deepest-subtree node)
    (if (null? node)
        (cons 0 null)
        (let* ((left-result (find-deepest-subtree (TreeNode-left node)))
               (left-depth (car left-result))
               (left-lca (cdr left-result))
               (right-result (find-deepest-subtree (TreeNode-right node)))
               (right-depth (car right-result))
               (right-lca (cdr right-result)))
          (cond
            ((> left-depth right-depth)
             (cons (+ left-depth 1) left-lca))
            ((< left-depth right-depth)
             (cons (+ right-depth 1) right-lca))
            (else
             (cons (+ left-depth 1) node))))))

  (cdr (find-deepest-subtree root)))