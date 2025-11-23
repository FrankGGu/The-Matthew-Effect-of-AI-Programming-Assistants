(require data/queue)

(struct TreeNode (val left right))

(define (zigzag-level-order root)
  (define result '())
  (define q (make-queue))
  (define level 0)

  (when root
    (enqueue! q root))

  (let loop ()
    (unless (queue-empty? q)
      (define level-size (queue-count q))
      (define current-level-vals-rev '())

      (for ([i (in-range level-size)])
        (define node (dequeue! q))
        (set! current-level-vals-rev (cons (TreeNode-val node) current-level-vals-rev))

        (when (TreeNode-left node)
          (enqueue! q (TreeNode-left node)))
        (when (TreeNode-right node)
          (enqueue! q (TreeNode-right node))))

      (set! result (append result
                           (list (if (even? level)
                                     (reverse current-level-vals-rev)
                                     current-level-vals-rev))))
      (set! level (+ level 1))
      (loop)))
  result)