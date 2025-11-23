#|
(struct tree-node
  (val left right) #:mutable #:transparent)
(define (make-tree-node [val 0])
  (tree-node val #f #f))
|#

(define (tree-to-doubly-list root)
  (if (false? root)
      #f
      (let ([head #f]
            [prev #f])
        (define (in-order node)
          (when node
            (in-order (tree-node-left node))
            (if prev
                (begin
                  (set-tree-node-right! prev node)
                  (set-tree-node-left! node prev))
                (set! head node))
            (set! prev node)
            (in-order (tree-node-right node))))
        (in-order root)
        (set-tree-node-right! prev head)
        (set-tree-node-left! head prev)
        head)))