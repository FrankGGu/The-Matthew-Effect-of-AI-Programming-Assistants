(define-struct TreeNode (val left right))

(define (max-level-sum root)
  (define (helper queue level max-sum max-level)
    (if (null? queue)
        max-level
        (let* ((current-sum (foldl (lambda (node acc) (+ (TreeNode-val node) acc)) 0 queue))
               (next-level (filter (lambda (node) (not (null? node)))
                                   (map (lambda (node) (list (TreeNode-left node) (TreeNode-right node))) queue)))
               (next-level-sum current-sum))
          (if (> next-level-sum max-sum)
              (helper next-level (+ level 1) next-level-sum level)
              (helper next-level (+ level 1) max-sum max-level))))))
  (helper (list root) 1 (TreeNode-val root) 1))