(struct TreeNode (val left right))

(define (max-level-sum root)
  ; The problem states "The number of nodes in the tree is in the range [1, 10^4]."
  ; This guarantees that 'root' will not be null.
  ; Therefore, level 1 always exists and its sum can be used for initial max-sum.
  (let loop ((current-q (list root)) ; Queue for nodes at the current level
             (current-level 1)
             (max-sum (TreeNode-val root)) ; Initialize with sum of level 1
             (max-level 1))
    (if (empty? current-q)
        max-level
        (let-values (((level-sum next-q-children-reversed)
                      (foldl (lambda (node acc)
                               (let-values (((sum children-acc) acc))
                                 (values (+ sum (TreeNode-val node))
                                         (let ((children-with-right (if (TreeNode-right node)
                                                                        (cons (TreeNode-right node) children-acc)
                                                                        children-acc)))
                                           (if (TreeNode-left node)
                                               (cons (TreeNode-left node) children-with-right)
                                               children-with-right)))))
                             (values 0 '())
                             current-q)))
          (let ((next-q-children (reverse next-q-children-reversed)))
            (if (> level-sum max-sum)
                (loop next-q-children
                      (+ current-level 1)
                      level-sum
                      current-level)
                (loop next-q-children
                      (+ current-level 1)
                      max-sum
                      max-level)))))))