(define/contract (build-tree inorder postorder)
  (-> (listof exact-integer?) (listof exact-integer?) (or/c #f tree-node?))
  (define (helper in-order post-order)
    (if (null? in-order)
        #f
        (let* ([root-val (last post-order)]
               [root (make-tree-node root-val)]
               [root-pos (index-of in-order root-val)]
               [left-in (take in-order root-pos)]
               [right-in (drop in-order (add1 root-pos))]
               [left-post (take post-order (length left-in))]
               [right-post (take (drop post-order (length left-in)) (length right-in))])
          (set-tree-node-left! root (helper left-in left-post))
          (set-tree-node-right! root (helper right-in right-post))
          root)))
  (helper inorder postorder))