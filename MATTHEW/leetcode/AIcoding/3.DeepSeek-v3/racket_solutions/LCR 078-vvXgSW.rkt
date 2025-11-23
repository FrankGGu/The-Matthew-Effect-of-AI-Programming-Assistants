(define/contract (merge-k-lists lists)
  (-> (listof (or/c null (listof exact-integer?))) (or/c null (listof exact-integer?)))
  (define (merge-two-lists l1 l2)
    (cond
      [(null? l1) l2]
      [(null? l2) l1]
      [(< (car l1) (car l2))
       (cons (car l1) (merge-two-lists (cdr l1) l2))]
      [else
       (cons (car l2) (merge-two-lists l1 (cdr l2)))]))
  (if (null? lists)
      '()
      (let loop ([lsts lists])
        (if (null? (cdr lsts))
            (car lsts)
            (loop (cons (merge-two-lists (car lsts) (cadr lsts)) (cddr lsts)))))))