(define (repeat-letter s)
  (define (helper seen chars)
    (cond
      [(null? chars) #f]
      [(memv (car chars) seen) (car chars)]
      [else (helper (cons (car chars) seen) (cdr chars))]))
  (helper '() (string->list s)))