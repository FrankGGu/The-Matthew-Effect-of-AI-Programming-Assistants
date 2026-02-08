#lang racket

(require racket/queue)

(struct TreeNode (val left right))

(define (largest-values root)
  (if (null? root)
      '()
      (let ([q (make-queue)])
        (queue-push! q root)
        (let loop ([acc '()])
          (if (queue-empty? q)
              (reverse acc)
              (let* ([level-size (queue-count q)]
                     [current-level-nodes (for/list ([_ (in-range level-size)])
                                            (queue-pop! q))]
                     [current-max (apply max (map TreeNode-val current-level-nodes))])

                (for ([node current-level-nodes])
                  (when (not (null? (TreeNode-left node)))
                    (queue-push! q (TreeNode-left node)))
                  (when (not (null? (TreeNode-right node)))
                    (queue-push! q (TreeNode-right node))))
                (loop (cons current-max acc))))))))