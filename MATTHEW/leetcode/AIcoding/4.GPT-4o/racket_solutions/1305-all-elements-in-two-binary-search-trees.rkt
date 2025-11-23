(define (get-all-elements root1 root2)
  (define (inorder-traversal root)
    (if (null? root)
        '()
        (append (inorder-traversal (car root))
                (list (cadr root))
                (inorder-traversal (caddr root)))))

  (define elements1 (inorder-traversal root1))
  (define elements2 (inorder-traversal root2))
  (define (merge l1 l2)
    (cond
      [(null? l1) l2]
      [(null? l2) l1]
      [(< (car l1) (car l2)) (cons (car l1) (merge (cdr l1) l2))]
      [else (cons (car l2) (merge l1 (cdr l2)))]))

  (merge elements1 elements2))