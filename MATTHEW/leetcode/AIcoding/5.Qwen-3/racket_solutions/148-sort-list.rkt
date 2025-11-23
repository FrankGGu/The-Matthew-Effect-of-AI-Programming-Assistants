(define (sort-list head)
  (define (merge left right)
    (cond ((null? left) right)
          ((null? right) left)
          ((<= (car left) (car right))
           (cons (car left) (merge (cdr left) right)))
          (else (cons (car right) (merge left (cdr right))))))

  (define (split lst)
    (if (or (null? lst) (null? (cdr lst)))
        (values lst #f)
        (let* ((slow lst)
               (fast (cdr lst))
               (next (cdr (cdr lst))))
          (set-cdr! slow #f)
          (values slow next))))

  (define (merge-sort lst)
    (if (or (null? lst) (null? (cdr lst)))
        lst
        (let-values (((left right) (split lst)))
          (merge (merge-sort left) (merge-sort right)))))

  (merge-sort head))