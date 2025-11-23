(struct TreeNode (val left right))

(define (get-leftmost-height node)
  (if (null? node)
      -1
      (+ 1 (get-leftmost-height (TreeNode-left node)))))

(define (count-nodes root)
  (if (null? root)
      0
      (let* ((left-height (get-leftmost-height (TreeNode-left root)))
             (right-height (get-leftmost-height (TreeNode-right root))))
        (if (= left-height right-height)
            (+ (expt 2 (+ left-height 1))
               (count-nodes (TreeNode-right root)))
            (+ (expt 2 (+ right-height 1))
               (count-nodes (TreeNode-left root)))))))