(define (clear-digits n)
  (define (helper lst)
    (cond
      [(null? lst) '()]
      [(and (>= (car lst) #\0) (<= (car lst) #\9)) (helper (cdr lst))]
      [else (cons (car lst) (helper (cdr lst)))]))
  (list->string (helper (string->list n))))