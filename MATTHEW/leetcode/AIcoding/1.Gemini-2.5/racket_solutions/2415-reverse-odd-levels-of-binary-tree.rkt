(define-struct TreeNode (val left right))

(define (reverse-odd-levels root)
  (unless (null? root)
    (let loop ((current-level-nodes-q (list root)) (level 0))
      (unless (null? current-level-nodes-q)
        (let* ((nodes-at-this-level '())
               (values-at-this-level '())
               (next-level-nodes-acc '()))

          (let process-current-level ((q current-level-nodes-q))
            (unless (null? q)
              (let ((node (car q)))
                (set! nodes-at-this-level (cons node nodes-at-this-level))
                (set! values-at-this-level (cons (TreeNode-val node) values-at-this-level))

                (when (TreeNode-left node)
                  (set! next-level-nodes-acc (cons (TreeNode-left node) next-level-nodes-acc)))
                (when (TreeNode-right node)
                  (set! next-level-nodes-acc (cons (TreeNode-right node) next-level-nodes-acc)))

                (process-current-level (cdr q)))))

          (set! nodes-at-this-level (reverse nodes-at-this-level))
          (set! values-at-this-level (reverse values-at-this-level))

          (when (odd? level)
            (let ((reversed-values (reverse values-at-this-level)))
              (for-each
               (lambda (node value)
                 (set-TreeNode-val! node value))
               nodes-at-this-level
               reversed-values)))

          (loop (reverse next-level-nodes-acc) (+ level 1))))))
  root)