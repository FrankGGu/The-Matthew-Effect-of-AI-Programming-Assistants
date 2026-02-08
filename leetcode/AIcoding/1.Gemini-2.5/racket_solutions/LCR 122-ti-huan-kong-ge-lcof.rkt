(define-struct (TreeNode val left right))

(define (tree2str root)
  (if (null? root)
      ""
      (let* ((val-str (number->string (TreeNode-val root)))
             (left-node (TreeNode-left root))
             (right-node (TreeNode-right root)))
        (cond
          ((and (null? left-node) (null? right-node))
           val-str)
          ((and (not (null? left-node)) (null? right-node))
           (string-append val-str "(" (tree2str left-node) ")"))
          ((and (null? left-node) (not (null? right-node)))
           (string-append val-str "()(" (tree2str right-node) ")"))
          (else ; both left and right exist
           (string-append val-str
                          "(" (tree2str left-node) ")"
                          "(" (tree2str right-node) ")"))))))