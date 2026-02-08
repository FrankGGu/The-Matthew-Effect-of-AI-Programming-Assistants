#lang racket

(require data/queue)

(define (level-order-bottom root)
  (define result '())
  (when root
    (define q (make-queue))
    (enqueue! q root)

    (let loop ()
      (unless (queue-empty? q)
        (define level-size (queue-count q))
        (define current-level-nodes '())
        (for ([_ (in-range level-size)])
          (define node (dequeue! q))
          (set! current-level-nodes (cons (TreeNode-val node) current-level-nodes))
          (when (TreeNode-left node)
            (enqueue! q (TreeNode-left node)))
          (when (TreeNode-right node)
            (enqueue! q (TreeNode-right node))))
        (set! result (cons (reverse current-level-nodes) result))
        (loop))))
  result)