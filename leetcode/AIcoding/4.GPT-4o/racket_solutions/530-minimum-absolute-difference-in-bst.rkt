(define (getMinimumDifference root)
  (define prev #f)
  (define min-diff (list 9999999))

  (define (inorder node)
    (when node
      (inorder (tree-left node))
      (when prev
        (set! min-diff (min (car min-diff) (- (tree-val node) (tree-val prev)))))
      (set! prev node)
      (inorder (tree-right node)))
  )

  (inorder root)
  (car min-diff))