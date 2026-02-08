(define-struct (TreeNode) (val left right))

(define (is-even-odd-tree root)
  (if (null? root)
      #t
      (let loop ((q (list root)) (level 0))
        (if (empty? q)
            #t
            (let* ((current-level-nodes q)
                   (next-q-rev '())
                   (prev-val (if (even? level) -1 1000001)))

              (let check-nodes ((nodes-to-process current-level-nodes) (current-prev-val prev-val))
                (if (empty? nodes-to-process)
                    (loop (reverse next-q-rev) (+ level 1))
                    (let* ((node (car nodes-to-process))
                           (val (TreeNode-val node)))
                      (cond
                        ((even? level)
                         (if (or (even? val) (<= val current-prev-val))
                             #f
                             (begin
                               (when (TreeNode-left node) (set! next-q-rev (cons (TreeNode-left node) next-q-rev)))
                               (when (TreeNode-right node) (set! next-q-rev (cons (TreeNode-right node) next-q-rev)))
                               (check-nodes (cdr nodes-to-process) val))))
                        ((odd? level)
                         (if (or (odd? val) (>= val current-prev-val))
                             #f
                             (begin
                               (when (TreeNode-left node) (set! next-q-rev (cons (TreeNode-left node) next-q-rev)))
                               (when (TreeNode-right node) (set! next-q-rev (cons (TreeNode-right node) next-q-rev)))
                               (check-nodes (cdr nodes-to-process) val))))))))))))