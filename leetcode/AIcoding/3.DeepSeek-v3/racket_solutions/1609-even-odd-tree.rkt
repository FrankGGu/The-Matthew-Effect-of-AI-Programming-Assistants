(define/contract (is-even-odd-tree root)
  (-> (or/c null? tree-node?) boolean?)
  (if (null? root)
      #t
      (let loop ([queue (list root)]
                 [level 0])
        (if (null? queue)
            #t
            (let* ([vals (map (lambda (node) (tree-node-val node)) queue)]
                   [valid? (if (even? level)
                               (and (andmap odd? vals)
                                    (apply < vals))
                               (and (andmap even? vals)
                                    (apply > vals)))])
              (if (not valid?)
                  #f
                  (loop (append* (map (lambda (node)
                                      (filter (lambda (x) (not (null? x)))
                                      (list (tree-node-left node) (tree-node-right node)))
                                    queue))
                          (add1 level)))))))