(define (alternatingGroups II lst)
  (define (helper lst acc)
    (cond
      [(null? lst) acc]
      [(= (modulo (length acc) 2) 0) (helper (cdr lst) (cons (car lst) acc))]
      [else (helper (cdr lst) (cons (car lst) (cdr acc)))]))
  (reverse (helper lst '())))