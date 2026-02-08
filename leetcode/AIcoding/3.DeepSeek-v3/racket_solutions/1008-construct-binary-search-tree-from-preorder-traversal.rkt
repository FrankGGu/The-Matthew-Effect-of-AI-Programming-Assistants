(define/contract (bst-from-preorder preorder)
  (-> (listof exact-integer?) (or/c #f tree-node?))
  (define (helper preorder lower upper)
    (if (null? preorder)
        (cons null preorder)
        (let ([val (car preorder)])
          (if (or (< val lower) (> val upper))
              (cons null preorder)
              (let* ([root (tree-node val)]
                     [preorder (cdr preorder)]
                     [left-result (helper preorder lower val)]
                     [left (car left-result)]
                     [preorder (cdr left-result)]
                     [right-result (helper preorder val upper)]
                     [right (car right-result)]
                     [preorder (cdr right-result)])
                (set-tree-node-left! root left)
                (set-tree-node-right! root right)
                (cons root preorder))))))
  (car (helper preorder -inf.0 +inf.0)))