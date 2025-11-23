(define (TreeNode val)
  (struct:TreeNode val left right #:mutable))

(define complete-binary-tree-inserter%
  (class object%
    (init root)
    (super-new)

    (define current-root root)
    (define queue (list current-root))

    (define/public (insert v)
      (let loop ([q queue])
        (cond
          [(null? q) #f]
          [else
           (let ([node (car q)])
             (cond
               [(null? (TreeNode-left node))
                (let ([new-node (TreeNode v null null)])
                  (set-TreeNode-left! node new-node)
                  (set! queue (append queue (list new-node)))
                  (TreeNode-val node)))
               [(null? (TreeNode-right node))
                (let ([new-node (TreeNode v null null)])
                  (set-TreeNode-right! node new-node)
                  (set! queue (append queue (list new-node)))
                  (set! queue (cdr q))
                  (TreeNode-val node)))
               [else
                (loop (cdr q))]))])))

    (define/public (get_root)
      current-root)))

(define CompleteBinaryTreeInserter (new complete-binary-tree-inserter%))