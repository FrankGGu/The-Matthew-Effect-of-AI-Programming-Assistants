(define (sort-list head)
  (define (merge l1 l2)
    (cond
      [(null? l1) l2]
      [(null? l2) l1]
      [(< (car l1) (car l2)) (cons (car l1) (merge (cdr l1) l2))]
      [else (cons (car l2) (merge l1 (cdr l2)))]))

  (define (split lst)
    (if (null? lst)
        (values null null)
        (let-values (split (cdr lst))
          (if (null? (car-values))
              (values (cons (car lst) (car-values)) (cdr-values))
              (values (car-values) (cons (car lst) (cdr-values)))))))

  (define (merge-sort lst)
    (if (or (null? lst) (null? (cdr lst)))
        lst
        (let-values (split lst)
          (merge (merge-sort (car-values)) (merge-sort (cdr-values))))))

  (merge-sort head))