(define/contract (find-bottom-left-value root)
  (-> (or/c null? tree-node?) exact-integer?)
  (let loop ([queue (if (null? root) '() (list root))] [leftmost 0])
    (if (null? queue)
        leftmost
        (let* ([node (car queue)]
               [rest-queue (cdr queue)]
               [leftmost (if (null? rest-queue) (tree-node-val node) leftmost)])
          (loop (append rest-queue 
                         (filter (lambda (x) (not (null? x)))
                                 (list (tree-node-left node) (tree-node-right node))))
                leftmost))))))