(define/contract (is-complete-tree root)
  (-> (or/c null? tree-node?) boolean?)
  (if (null? root)
      #t
      (let ([queue (make-queue)])
        (enqueue! queue root)
        (let loop ([seen-null #f])
          (if (queue-empty? queue)
              #t
              (let ([node (dequeue! queue)])
                (cond
                  [(null? node) (loop #t)]
                  [seen-null #f]
                  [else
                   (enqueue! queue (tree-node-left node))
                   (enqueue! queue (tree-node-right node))
                   (loop #f)])))))))