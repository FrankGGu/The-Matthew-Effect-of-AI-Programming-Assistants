(define/contract (lowest-common-ancestor root p q)
  (-> (or/c #f (tree-node?)) (tree-node?) (tree-node?) (tree-node?))
  (let loop ([node root])
    (cond
      [(or (not node) (= (tree-node-val node) (tree-node-val p)) (= (tree-node-val node) (tree-node-val q))) node]
      [(and (< (tree-node-val p) (tree-node-val node)) (< (tree-node-val q) (tree-node-val node))) (loop (tree-node-left node))]
      [(and (> (tree-node-val p) (tree-node-val node)) (> (tree-node-val q) (tree-node-val node))) (loop (tree-node-right node))]
      [else node])))