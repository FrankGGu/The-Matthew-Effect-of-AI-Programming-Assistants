(define-struct node (val children))

(define (preorder root)
  (if (null? root)
      '()
      (cons (node-val root)
            (apply append (map preorder (node-children root))))))