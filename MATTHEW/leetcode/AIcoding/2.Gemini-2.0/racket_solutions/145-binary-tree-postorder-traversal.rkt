(define (postorder-traversal root)
  (define result '())
  (define (traverse node)
    (when node
      (traverse (car node))
      (traverse (cdr node))
      (set! result (append result (list (cadr node))))))
  (traverse root)
  result)