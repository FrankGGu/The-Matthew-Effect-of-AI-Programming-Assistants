(define/contract (merge-two-lists l1 l2)
  (-> (or/c null? list?) (or/c null? list?) (or/c null? list?))
  (cond
    [(null? l1) l2]
    [(null? l2) l1]
    [(< (car l1) (car l2))
     (cons (car l1) (merge-two-lists (cdr l1) l2))]
    [else
     (cons (car l2) (merge-two-lists l1 (cdr l2)))]))