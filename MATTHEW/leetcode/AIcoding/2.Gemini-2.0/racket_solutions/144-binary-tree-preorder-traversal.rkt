(define (preorder-traversal root)
  (define result '())
  (define (traverse node)
    (when node
      (set! result (append result (list (struct-ref node 0))))
      (traverse (struct-ref node 1))
      (traverse (struct-ref node 2))))
  (traverse root)
  result)