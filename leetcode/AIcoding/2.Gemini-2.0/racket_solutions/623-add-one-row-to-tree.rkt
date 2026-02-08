(define (add-one-row root v d)
  (define (add-row node depth)
    (cond
      [(null? node) null]
      [(= depth d)
       (cons (cons v (car node)) (cons v (cdr node)))]
      [(< depth d)
       (cons (add-row (car node) (+ depth 1))
             (add-row (cdr node) (+ depth 1)))]
      [else node]))
  (if (= d 1)
      (cons (cons v root) null)
      (cons (add-row root 2) null)))