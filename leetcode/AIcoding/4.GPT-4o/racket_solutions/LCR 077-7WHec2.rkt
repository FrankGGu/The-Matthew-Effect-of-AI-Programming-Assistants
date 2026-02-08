(define (sort-list head)
  (define (merge left right)
    (cond
      [(null? left) right]
      [(null? right) left]
      [(< (car left) (car right)) (cons (car left) (merge (cdr left) right))]
      [else (cons (car right) (merge left (cdr right)))]))

  (define (split lst)
    (let loop ((slow lst) (fast lst) (prev null))
      (cond
        [(null? fast) (values prev slow)]
        [(null? (cdr fast)) (values prev slow)]
        [else (loop (cdr slow) (cdr (cdr fast)) slow)])))

  (define (merge-sort lst)
    (if (or (null? lst) (null? (cdr lst)))
        lst
        (let-values (split lst)
          (merge (merge-sort it1) (merge-sort it2)))))

  (merge-sort head))