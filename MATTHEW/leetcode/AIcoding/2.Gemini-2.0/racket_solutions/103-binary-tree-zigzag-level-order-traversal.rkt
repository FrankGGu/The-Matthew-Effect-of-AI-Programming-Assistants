(define (zigzag-level-order root)
  (define (level-order-helper node level result reversed?)
    (if (null? node)
        result
        (let ((new-result (if (>= (length result) level)
                               (list-set result (sub1 level) (cons (node->val node) (list-ref result (sub1 level))))
                               (append result (list (list (node->val node)))))))
          (let ((left-first (if reversed? (node->right node) (node->left node)))
                (right-first (if reversed? (node->left node) (node->right node))))
            (level-order-helper left-first (+ level 1) new-result reversed?)
            (level-order-helper right-first (+ level 1) new-result reversed?)))))

  (define (reverse-every-other list-of-lists)
    (map (lambda (lst idx)
           (if (even? idx)
               lst
               (reverse lst)))
         list-of-lists
         (range (length list-of-lists))))

  (if (null? root)
      '()
      (reverse-every-other (level-order-helper root 1 '() #f))))