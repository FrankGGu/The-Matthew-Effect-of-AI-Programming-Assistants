(define (merge-k-lists lists)
  (define (merge-two l1 l2)
    (cond
      [(null? l1) l2]
      [(null? l2) l1]
      [(< (car l1) (car l2))
       (cons (car l1) (merge-two (cdr l1) l2))]
      [else
       (cons (car l2) (merge-two l1 (cdr l2)))]))

  (define (merge-all lst)
    (if (null? lst)
        '()
        (foldl merge-two '() lst)))

  (merge-all lists))