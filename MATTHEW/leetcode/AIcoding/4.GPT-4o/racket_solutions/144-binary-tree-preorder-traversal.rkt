(define (preorderTraversal root)
  (define (traverse node result)
    (if (null? node)
        result
        (let* ((new-result (cons (node-value node) result)))
          (traverse (node-left node) (traverse (node-right node) new-result)))))
  (reverse (traverse root '())))