(define (delete-node node)
  (set! (node-value node) (node-value (node-next node)))
  (set! (node-next node) (node-next (node-next node))))