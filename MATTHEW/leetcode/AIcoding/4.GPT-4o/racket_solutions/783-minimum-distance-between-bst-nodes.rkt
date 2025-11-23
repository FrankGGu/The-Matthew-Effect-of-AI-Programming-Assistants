(define (minDiffInBST root)
  (define (inorder n)
    (if (null? n)
        '()
        (append (inorder (tree-left n)) (list (tree-val n)) (inorder (tree-right n)))))

  (define values (inorder root))
  (define (min-diff lst)
    (if (null? (cdr lst))
        +inf.0
        (min (abs (- (car lst) (cadr lst))) (min-diff (cdr lst)))))

  (min-diff (sort values <)))