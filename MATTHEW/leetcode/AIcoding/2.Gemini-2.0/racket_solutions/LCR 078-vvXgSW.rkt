(define (merge-k-lists lists)
  (define (merge-two-lists l1 l2)
    (cond
      [(null? l1) l2]
      [(null? l2) l1]
      [(<= (car l1) (car l2)) (cons (car l1) (merge-two-lists (cdr l1) l2))]
      [else (cons (car l2) (merge-two-lists l1 (cdr l2)))]))

  (define (merge-lists lists)
    (cond
      [(null? lists) null]
      [(null? (cdr lists)) (car lists)]
      [else
       (let* ([mid (quotient (length lists) 2)]
              [left (take lists mid)]
              [right (drop lists mid)])
         (merge-two-lists (merge-lists left) (merge-lists right)))]))

  (merge-lists lists))