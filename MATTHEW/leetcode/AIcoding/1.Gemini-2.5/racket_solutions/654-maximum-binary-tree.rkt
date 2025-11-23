(struct TreeNode (val left right))

(define (find-max-and-index nums)
  (let loop ((lst (cdr nums))
             (idx 1)
             (max-val (car nums))
             (max-idx 0))
    (cond
      ((empty? lst) (cons max-val max-idx))
      (else
       (let ((current-val (car lst)))
         (if (> current-val max-val)
             (loop (cdr lst) (+ idx 1) current-val idx)
             (loop (cdr lst) (+ idx 1) max-val max-idx)))))))

(define (constructMaximumBinaryTree nums)
  (if (empty? nums)
      null
      (let* ((max-info (find-max-and-index nums))
             (max-val (car max-info))
             (max-idx (cdr max-info)))
        (let-values (((left-sublist right-sublist-with-max)
                      (split-at nums max-idx)))
          (let ((left-child (constructMaximumBinaryTree left-sublist))
                (right-child (constructMaximumBinaryTree (cdr right-sublist-with-max))))
            (TreeNode max-val left-child right-child))))))