(define (seconds-to-remove-occurences s)
  (define (helper s count)
    (define lst (string->list s))
    (define (replace lst)
      (cond
        [(null? lst) '()]
        [(null? (cdr lst)) lst]
        [(and (char=? (car lst) #\0) (char=? (cadr lst) #\1))
         (cons #\1 (cons #\0 (replace (cddr lst))))]
        [else (cons (car lst) (replace (cdr lst)))]))
    (define new-s (list->string (replace lst)))
    (if (string=? new-s s)
        count
        (helper new-s (add1 count))))
  (helper s 0))