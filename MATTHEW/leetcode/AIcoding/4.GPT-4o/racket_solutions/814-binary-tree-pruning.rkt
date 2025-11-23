(define (pruneTree root)
  (if (null? root)
      #f
      (begin
        (set-cdr! root (filter (lambda (x) (or (equal? (tree-val x) 1) (pruneTree x))) (cdr root)))
        (if (equal? (tree-val root) 1)
            root
            (if (null? (cdr root))
                #f
                root)))))