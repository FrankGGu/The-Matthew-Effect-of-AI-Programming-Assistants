(define (lowestCommonAncestor root p q)
  (cond
    [(null? root) #f]
    [(= (send p value) (send root value)) root]
    [(= (send q value) (send root value)) root]
    [(< (send p value) (send root value) (send q value)) 
     (lowestCommonAncestor (send root left) p q)]
    [else 
     (lowestCommonAncestor (send root right) p q)]))