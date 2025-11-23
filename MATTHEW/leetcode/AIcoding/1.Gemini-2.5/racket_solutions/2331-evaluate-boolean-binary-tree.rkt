#lang racket

(define (evaluate-tree root)
  (let ((node-val (TreeNode-val root)))
    (cond
      ((= node-val 0) #f)
      ((= node-val 1) #t)
      ((= node-val 2) ; OR
       (or (evaluate-tree (TreeNode-left root))
           (evaluate-tree (TreeNode-right root))))
      ((= node-val 3) ; AND
       (and (evaluate-tree (TreeNode-left root))
            (evaluate-tree (TreeNode-right root)))))))