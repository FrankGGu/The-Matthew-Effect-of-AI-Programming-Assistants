(define/contract (build-tree preorder inorder)
  (-> (listof exact-integer?) (listof exact-integer?) (or/c tree-node? #f))
  (if (null? preorder)
      #f
      (let ([root-val (car preorder)]
            [root-pos (index-of inorder (car preorder))])
        (let ([left-size root-pos]
              [right-size (- (length inorder) root-pos 1)])
          (let ([left-preorder (take (cdr preorder) left-size)]
                [right-preorder (drop (cdr preorder) left-size)]
                [left-inorder (take inorder left-size)]
                [right-inorder (drop inorder (+ left-size 1))])
            (tree-node root-val
                       (build-tree left-preorder left-inorder)
                       (build-tree right-preorder right-inorder)))))))