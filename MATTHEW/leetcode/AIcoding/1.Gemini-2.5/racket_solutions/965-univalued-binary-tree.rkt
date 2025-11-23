(struct TreeNode (val left right))

(define (is-unival-tree root)
  (if (not root)
      #t
      (let ((val (TreeNode-val root)))
        (define (check-val node expected-val)
          (cond
            ((not node) #t)
            ((not (= (TreeNode-val node) expected-val)) #f)
            (else
             (and (check-val (TreeNode-left node) expected-val)
                  (check-val (TreeNode-right node) expected-val)))))
        (check-val root val))))