(define-struct TreeNode (val left right))

(define (rob-helper node)
  (if (not node)
      (cons 0 0) ; (robbed_value, not_robbed_value)
      (let* ((left-results (rob-helper (TreeNode-left node)))
             (right-results (rob-helper (TreeNode-right node)))
             (left-robbed (car left-results))
             (left-not-robbed (cdr left-results))
             (right-robbed (car right-results))
             (right-not-robbed (cdr right-results)))
        (let ((current-robbed
               (+ (TreeNode-val node) left-not-robbed right-not-robbed))
              (current-not-robbed
               (+ (max left-robbed left-not-robbed)
                  (max right-robbed right-not-robbed))))
          (cons current-robbed current-not-robbed)))))

(define (rob root)
  (let ((results (rob-helper root)))
    (max (car results) (cdr results))))