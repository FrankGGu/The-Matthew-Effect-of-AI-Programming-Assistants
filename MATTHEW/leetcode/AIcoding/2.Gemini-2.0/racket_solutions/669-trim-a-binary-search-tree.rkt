(define (trimBST root low high)
  (cond
    [(null? root) null]
    [(< (car root) low) (trimBST (caddr root) low high)]
    [(> (car root) high) (trimBST (cadr root) low high)]
    [else (cons (car root)
                 (cons (trimBST (cadr root) low high)
                       (cons (trimBST (caddr root) low high) null)))]))