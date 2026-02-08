(define (remove-zero-sum-sublists head)
  (define (list->hash lst)
    (define (helper lst sum idx acc)
      (cond
        [(null? lst) acc]
        [else
         (let* ([new-sum (+ sum (car lst))]
                [new-acc (hash-set acc new-sum idx)])
           (helper (cdr lst) new-sum (+ idx 1) new-acc))]))
    (helper lst 0 0 (hash)))

  (define (hash->list h lst)
    (define (helper h lst sum idx)
      (cond
        [(null? lst) lst]
        [else
         (let ([sum-idx (hash-ref h sum #f)])
           (if sum-idx
               (helper h (drop lst (- idx sum-idx)) 0 0)
               (cons (car lst) (helper h (cdr lst) (+ sum (car lst)) (+ idx 1)))))]))
    (helper (list->hash lst) lst 0 0))

  (define (list->linked-list lst)
    (cond
      [(null? lst) #f]
      [else (cons `(, (car lst) . ,(list->linked-list (cdr lst))))]))

  (define (linked-list->list lst)
    (cond
      [(not lst) '()]
      [else (cons (caar lst) (linked-list->list (cdr lst)))]))

  (list->linked-list (hash->list (linked-list->list head))))