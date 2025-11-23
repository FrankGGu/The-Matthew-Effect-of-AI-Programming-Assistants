(define (invert-tree root)
  (if (null? root)
      null
      (let* ((left (invert-tree (cdr root)))
             (right (invert-tree (cddr root))))
        (cons (car root) (cons right (cons left '()))))))