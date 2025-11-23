(define (copyRandomList head)
  (define (clone-node node)
    (if (null? node)
        #f
        (let ((new-node (make-node (node-val node))))
          (set-node-random! new-node (node-random node))
          (set-node-next! new-node (clone-node (node-next node)))
          new-node)))

  (define (update-random old new)
    (if (null? old)
        '()
        (begin
          (set-node-random! new (if (node-random old)
                                    (find-node (node-random old) new)
                                    #f))
          (update-random (node-next old) (node-next new))
          new)))

  (define (find-node target node)
    (if (null? node)
        #f
        (if (equal? (node-val node) (node-val target))
            node
            (find-node target (node-next node)))))

  (if (null? head)
      #f
      (let ((new-head (clone-node head)))
        (update-random head new-head)
        new-head)))