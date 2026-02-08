(define/contract (max-level-sum root)
  (-> (or/c null? tree-node?) exact-integer?)
  (if (null? root)
      0
      (let loop ([queue (list root)]
                 [max-sum -inf.0]
                 [max-level 1]
                 [current-level 1])
        (if (null? queue)
            max-level
            (let* ([level-sum (apply + (map (lambda (node) (tree-node-val node)) queue))]
                   [new-queue (append* (map (lambda (node)
                                             (filter (lambda (x) (not (null? x)))
                                             (list (tree-node-left node) (tree-node-right node)))
                                           queue)])
              (if (> level-sum max-sum)
                  (loop new-queue level-sum current-level (add1 current-level))
                  (loop new-queue max-sum max-level (add1 current-level))))))))