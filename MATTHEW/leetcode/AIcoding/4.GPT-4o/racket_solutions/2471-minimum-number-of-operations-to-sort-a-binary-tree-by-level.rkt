(define-struct TreeNode (val left right))

(define (minOperations(root))
  (define (level-order-traversal node)
    (define (helper queue result)
      (if (null? queue)
          result
          (let* ((current-level (map car queue))
                 (next-level (apply append (map (lambda (x) (list (TreeNode-left x) (TreeNode-right x))) queue)))
                 (sorted-level (sort < current-level))
                 (count (count-mismatches current-level sorted-level)))
            (helper next-level (cons count result)))))
    (helper (list node) '()))

  (define (count-mismatches original sorted)
    (length (filter (lambda (x) (not (equal? (car x) (cadr x))))
                    (map list original sorted))))

  (apply + (level-order-traversal root)))