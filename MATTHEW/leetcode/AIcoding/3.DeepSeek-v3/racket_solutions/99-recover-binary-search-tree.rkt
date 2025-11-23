(define/contract (recover-binary-search-tree root)
  (-> (or/c null? tree-node?) void?)
  (define prev (make-parameter (box (cons null -inf.0))))
  (define first (make-parameter null))
  (define second (make-parameter null))

  (define (inorder node)
    (when (not (null? node))
      (inorder (tree-node-left node))
      (let ([val (tree-node-val node)]
            [prev-val (cdr (unbox (prev)))])
        (when (< val prev-val)
          (if (null? (first))
              (begin
                (first (unbox (prev)))
                (second node))
              (second node)))
        (prev (box (cons node val))))
      (inorder (tree-node-right node))))

  (inorder root)
  (let ([tmp (tree-node-val (first))])
    (set-tree-node-val! (first) (tree-node-val (second)))
    (set-tree-node-val! (second) tmp)))