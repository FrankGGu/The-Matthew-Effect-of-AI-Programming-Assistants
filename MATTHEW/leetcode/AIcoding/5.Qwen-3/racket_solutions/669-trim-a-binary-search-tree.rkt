(define (trim-bst root low high)
  (cond
    [(null? root) null]
    [(> (car root) high) (trim-bst (cadr root) low high)]
    [(< (car root) low) (trim-bst (caddr root) low high)]
    [else
     (set! root (cons (car root) (trim-bst (cadr root) low high)))
     (set! root (cons (car root) (cons (cadr root) (trim-bst (caddr root) low high))))
     root]))