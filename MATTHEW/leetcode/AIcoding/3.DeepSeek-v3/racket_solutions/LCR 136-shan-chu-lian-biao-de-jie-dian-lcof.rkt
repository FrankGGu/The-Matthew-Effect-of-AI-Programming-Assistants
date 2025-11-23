(define/contract (delete-node node)
  (-> (or/c list-node? #f) void?)
  (when node
    (set-list-node-val! node (list-node-val (list-node-next node)))
    (set-list-node-next! node (list-node-next (list-node-next node))))