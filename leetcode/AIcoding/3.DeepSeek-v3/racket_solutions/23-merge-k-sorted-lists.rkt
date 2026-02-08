(define/contract (merge-k-lists lists)
  (-> (listof (or/c null? list?)) (or/c null? list?))
  (define (merge-two-lists l1 l2)
    (cond [(null? l1) l2]
          [(null? l2) l1]
          [(< (car l1) (car l2)) (cons (car l1) (merge-two-lists (cdr l1) l2))]
          [else (cons (car l2) (merge-two-lists l1 (cdr l2)))]))
  (if (null? lists)
      null
      (let loop ([lsts lists])
        (if (= (length lsts) 1)
            (car lsts)
            (loop (let merge-pairs ([l lsts])
                    (cond [(null? l) null]
                          [(null? (cdr l)) l]
                          [else (cons (merge-two-lists (car l) (cadr l))
                                      (merge-pairs (cddr l)))])))))))