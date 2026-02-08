(define (or-quad-trees quad-tree1 quad-tree2)
  (cond
    [(equal? quad-tree1 '()) quad-tree2]
    [(equal? quad-tree2 '()) quad-tree1]
    [(and (equal? (car quad-tree1) 1) (equal? (car quad-tree2) 1)) 
     (list 1 0 0 0)]
    [(and (equal? (car quad-tree1) 1) (equal? (car quad-tree2) 0)) 
     quad-tree1]
    [(and (equal? (car quad-tree1) 0) (equal? (car quad-tree2) 1)) 
     quad-tree2]
    [(and (equal? (car quad-tree1) 0) (equal? (car quad-tree2) 0)) 
     (list 0 0 0 0)]
    [else 
     (list 0 
           (or-quad-trees (cadr quad-tree1) (cadr quad-tree2)) 
           (or-quad-trees (caddr quad-tree1) (caddr quad-tree2)) 
           (or-quad-trees (cadddr quad-tree1) (cadddr quad-tree2)))]))