(define (mergeTwoLists l1 l2)
  (define (merge l1 l2 acc)
    (cond
      [(null? l1) (append acc l2)]
      [(null? l2) (append acc l1)]
      [(<= (car l1) (car l2)) (merge (cdr l1) l2 (append acc (list (car l1))))]
      [else (merge l1 (cdr l2) (append acc (list (car l2)))]))
  (merge l1 l2 '()))