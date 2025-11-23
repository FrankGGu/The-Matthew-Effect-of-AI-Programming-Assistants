(define (lowest-common-ancestor root p q)
  (cond
    [(null? root) #f]
    [(eq? root p) root]
    [(eq? root q) root]
    [else
     (let* ([left (lowest-common-ancestor (car root) p q)]
            [right (lowest-common-ancestor (cdr root) p q)])
       (cond
         [(and left right) root]
         [left left]
         [right right]
         [else #f]))]))