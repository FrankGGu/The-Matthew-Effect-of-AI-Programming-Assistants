(struct Node (val children))

(define (preorder root)
  (if (not root)
      '()
      (cons (Node-val root)
            (apply append (map preorder (Node-children root))))))