#lang racket

(struct TreeNode (val left right))

(define (insertIntoMaxTree root val)
  (if (null? root)
      (make-TreeNode val null null)
      (if (> val (TreeNode-val root))
          (make-TreeNode val root null)
          (let loop ((node root))
            (if (null? (TreeNode-right node))
                (set-TreeNode-right! node (make-TreeNode val null null))
                (if (> val (TreeNode-val (TreeNode-right node)))
                    (let ((new-node (make-TreeNode val null null)))
                      (set-TreeNode-right! node new-node)
                      (set-TreeNode-right! new-node (TreeNode-right node)))
                    (loop (TreeNode-right node)))))))