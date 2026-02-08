(define-struct TreeNode (val left right))

(define (is-balanced root)
  (define (check-balance-and-height node)
    (if (null? node)
        (list #t 0) ; (is-balanced? height)
        (let* ((left-info (check-balance-and-height (TreeNode-left node)))
               (right-info (check-balance-and-height (TreeNode-right node)))
               (left-balanced? (car left-info))
               (left-height (cadr left-info))
               (right-balanced? (car right-info))
               (right-height (cadr right-info)))
          (if (and left-balanced?
                   right-balanced?
                   (<= (abs (- left-height right-height)) 1))
              (list #t (+ 1 (max left-height right-height)))
              (list #f -1))))) ; -1 indicates imbalance, actual height doesn't matter
  (car (check-balance-and-height root)))