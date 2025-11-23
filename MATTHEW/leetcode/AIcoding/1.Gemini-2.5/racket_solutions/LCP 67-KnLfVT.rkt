#lang racket

(struct TreeNode (val left right))

(define (decorate-tree root)
  (if (not root)
      '()
      (let loop ((queue (list root))
                 (result '()))
        (if (empty? queue)
            (reverse result)
            (let-values (((current-level-nodes next-queue)
                          (for/fold ((acc-nodes '()) (acc-queue '()))
                                    ((node (in-list queue)))
                            (values (cons (TreeNode-val node) acc-nodes)
                                    (append acc-queue
                                            (if (TreeNode-left node) (list (TreeNode-left node)) '())
                                            (if (TreeNode-right node) (list (TreeNode-right node)) '()))))))
              (loop next-queue (cons (reverse current-level-nodes) result)))))))