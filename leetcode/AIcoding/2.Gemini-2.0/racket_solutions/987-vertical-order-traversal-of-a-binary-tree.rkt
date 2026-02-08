(define (vertical-traversal root)
  (define (helper node col row acc)
    (cond
      [(null? node) acc]
      [else
       (helper (->left node) (- col 1) (+ row 1)
               (helper (->right node) (+ col 1) (+ row 1)
                       (hash-update acc col
                                    (lambda (curr)
                                      (append curr (list (list row (->val node)))))
                                    (list (list row (->val node))))))]))

  (define (sort-vertical-order vertical-order)
    (map (lambda (col)
           (map second (sort (hash-ref vertical-order col)
                             (lambda (x y)
                               (cond
                                 [(< (first x) (first y)) #t]
                                 [(= (first x) (first y)) (< (second x) (second y))]
                                 [else #f])))))
         (sort (hash-keys (helper root 0 0 (make-hash))) <)))

  (if (null? root)
      '()
      (sort-vertical-order (helper root 0 0 (make-hash)))))