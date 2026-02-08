#lang racket

(struct TreeNode (val left right) #:transparent)

(require data/queue)

(define (largest-values root)
  (if (null? root)
      '()
      (let ((result-acc '()) ; Accumulator for results, built in reverse order
            (q (make-queue)))
        (enqueue! q root)
        (let loop ()
          (unless (queue-empty? q)
            (let* ((level-size (queue-size q))
                   (max-val-current-level -inf.0)) ; Initialize with negative infinity for comparison
              ;; Process all nodes for the current level
              (for ((i (range level-size)))
                (let ((node (dequeue! q)))
                  (set! max-val-current-level (max max-val-current-level (TreeNode-val node)))
                  (when (TreeNode-left node) (enqueue! q (TreeNode-left node)))
                  (when (TreeNode-right node) (enqueue! q (TreeNode-right node)))))
              ;; Add the max value for this level to the accumulator
              (set! result-acc (cons max-val-current-level result-acc))
              (loop))))
        (reverse result-acc))))