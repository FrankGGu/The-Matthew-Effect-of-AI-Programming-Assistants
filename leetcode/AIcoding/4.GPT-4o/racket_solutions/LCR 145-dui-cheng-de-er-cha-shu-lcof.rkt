(define (isSymmetric root)
  (define (isMirror tree1 tree2)
    (cond
      [(and (null? tree1) (null? tree2)) #t]
      [(or (null? tree1) (null? tree2)) #f]
      [(= (tree1-value tree1) (tree2-value tree2)) 
       (and (isMirror (tree1-left tree1) (tree2-right tree2))
            (isMirror (tree1-right tree1) (tree2-left tree2)))]
      [else #f]))
  (isMirror root root))