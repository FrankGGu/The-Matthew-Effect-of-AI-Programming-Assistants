(struct TreeNode (val left right))

(define (addOneRow root val depth)
  (cond
    ((= depth 1)
     (TreeNode val root #f))
    (else
     (define (traverse current-node current-depth)
       (cond
         ((not current-node)
          #f)
         ((= current-depth (- depth 1))
          (define new-left-child (TreeNode val (TreeNode-left current-node) #f))
          (define new-right-child (TreeNode val #f (TreeNode-right current-node)))
          (TreeNode (TreeNode-val current-node) new-left-child new-right-child))
         (else
          (TreeNode (TreeNode-val current-node)
                    (traverse (TreeNode-left current-node) (+ current-depth 1))
                    (traverse (TreeNode-right current-node) (+ current-depth 1))))))
     (traverse root 1))))