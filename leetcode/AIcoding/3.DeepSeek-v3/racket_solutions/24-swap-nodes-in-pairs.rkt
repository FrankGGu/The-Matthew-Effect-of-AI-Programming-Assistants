(define/contract (swap-pairs head)
  (-> (or/c list-node? #f) (or/c list-node? #f))
  (if (or (not head) (not (list-node-next head)))
      head
      (let ((next-node (list-node-next head)))
        (set-list-node-next! head (swap-pairs (list-node-next next-node)))
        (set-list-node-next! next-node head)
        next-node)))