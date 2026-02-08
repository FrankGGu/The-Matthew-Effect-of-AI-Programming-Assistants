(define/contract (delete-node node)
  (-> (and/c list-node? (not/c null?)) void?)
  (set-list-node-val! node (list-node-val (list-node-next node)))
  (set-list-node-next! node (list-node-next (list-node-next node))))