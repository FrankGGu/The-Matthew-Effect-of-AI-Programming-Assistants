(define (lowestCommonAncestor root p q)
  (cond
    [(null? root) #f]
    [(equal? root p) root]
    [(equal? root q) root]
    [else
     (define left (lowestCommonAncestor (root-left root) p q))
     (define right (lowestCommonAncestor (root-right root) p q))
     (cond
       [(and left right) root]
       [else (or left right)]]))])