(define (relative-sort-array arr1 arr2)
  (define (count-map lst)
    (for/fold ([m (hash)]) ([x lst])
      (hash-update m x add1 0)))

  (define (sort-helper lst m)
    (cond
      [(null? lst) '()]
      [else
       (append (make-list (hash-ref m (car lst)) (car lst))
               (sort-helper (cdr lst) m))]))

  (let ([m (count-map arr2)])
    (sort-helper arr1 m)))