(define (lowest-common-ancestor root p q)
  (let ((root-val (TreeNode-val root))
        (p-val (TreeNode-val p))
        (q-val (TreeNode-val q)))
    (cond
      ((and (< p-val root-val) (< q-val root-val))
       (lowest-common-ancestor (TreeNode-left root) p q))
      ((and (> p-val root-val) (> q-val root-val))
       (lowest-common-ancestor (TreeNode-right root) p q))
      (else
       root))))