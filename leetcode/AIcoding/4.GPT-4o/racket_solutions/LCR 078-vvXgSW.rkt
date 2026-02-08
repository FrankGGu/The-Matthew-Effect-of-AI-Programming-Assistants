(define (merge-k-lists lists)
  (define (merge-two-lists l1 l2)
    (cond
      [(null? l1) l2]
      [(null? l2) l1]
      [(< (car l1) (car l2)) (cons (car l1) (merge-two-lists (cdr l1) l2))]
      [else (cons (car l2) (merge-two-lists l1 (cdr l2)))]))

  (define (merge-lists lists)
    (if (null? lists)
        '()
        (if (= (length lists) 1)
            (car lists)
            (merge-lists (list (merge-two-lists (car lists) (cadr lists)) 
                               (cddr lists))))))

  (merge-lists lists))

(define (mergeKLists lists)
  (merge-k-lists lists))