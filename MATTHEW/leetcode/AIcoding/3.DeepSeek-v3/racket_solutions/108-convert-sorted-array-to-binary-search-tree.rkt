(define/contract (sorted-array-to-bst nums)
  (-> (listof exact-integer?) (or/c #f (tree-node?)))
  (define (helper left right)
    (if (> left right)
        #f
        (let* ([mid (quotient (+ left right) 2)]
               [root (tree-node (list-ref nums mid))]
          (set-tree-node-left! root (helper left (- mid 1)))
          (set-tree-node-right! root (helper (+ mid 1) right))
          root)))
  (helper 0 (- (length nums) 1)))