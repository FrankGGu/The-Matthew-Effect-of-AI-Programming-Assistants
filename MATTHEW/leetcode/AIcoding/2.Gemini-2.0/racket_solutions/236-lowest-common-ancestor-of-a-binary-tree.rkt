(define (lowest-common-ancestor root p q)
  (cond
    [(null? root) #f]
    [(equal? root p) root]
    [(equal? root q) root]
    [else
     (define left (lowest-common-ancestor (car root) p q))
     (define right (lowest-common-ancestor (cdr root) p q))
     (cond
       [(and left right) root]
       [left left]
       [right right]
       [else #f])]))