(define (symmetric-tree? root)
  (define (is-mirror? left right)
    (cond
      [(and (null? left) (null? right)) #t]
      [(or (null? left) (null? right)) #f]
      [else (and (= (car left) (car right))
                  (is-mirror? (cdr (car left)) (cdr (cdr right)))
                  (is-mirror? (cdr (cdr left)) (cdr (car right))))]))
  (cond
    [(null? root) #t]
    [else (is-mirror? (car root) (cdr root))]))