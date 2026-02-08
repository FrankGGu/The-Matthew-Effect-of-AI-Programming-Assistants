(define (same-tree? p q)
  (cond
    [(and (null? p) (null? q)) #t]
    [(or (null? p) (null? q)) #f]
    [else (and (= (car p) (car q))
                (same-tree? (cadr p) (cadr q))
                (same-tree? (caddr p) (caddr q)))]))