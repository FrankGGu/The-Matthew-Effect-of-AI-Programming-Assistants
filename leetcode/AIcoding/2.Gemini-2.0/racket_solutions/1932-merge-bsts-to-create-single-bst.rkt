(define (can-merge trees)
  (define (get-inorder tree)
    (cond
      [(null? tree) '()]
      [else (append (get-inorder (cdr (car tree))))
                    (list (car tree))
                    (get-inorder (cddr (car tree))))]))

  (define (is-bst? inorder)
    (cond
      [(or (null? inorder) (null? (cdr inorder))) #t]
      [else (and (<= (car (cdr inorder)) (car (car inorder)))
                 (is-bst? (cdr inorder)))]))

  (define (get-nodes trees)
    (foldl (lambda (tree acc) (append (get-inorder (list tree)) acc)) '() trees))

  (define (construct-bst nodes)
    (define (build-tree nodes)
      (if (null? nodes)
          '()
          (let* ((mid (quotient (length nodes) 2))
                 (root (list (list-ref nodes mid) '() '())))
            (set-car! (cdr root) (build-tree (take nodes mid)))
            (set-car! (cddr root) (build-tree (drop nodes (+ mid 1))))
            root)))

    (if (null? nodes)
        '()
        (build-tree nodes)))

  (let* ((all-nodes (get-nodes trees))
         (sorted-nodes (sort (remove-duplicates all-nodes) < #:key car))
         (merged-tree (construct-bst sorted-nodes)))
    (if (and (not (null? merged-tree)) (is-bst? (get-inorder (list merged-tree))) (= (length all-nodes) (length (remove-duplicates all-nodes))))
        (car merged-tree)
        '())))