(define (camelcase-matching queries pattern)
  (define (match query pattern)
    (define (helper q p)
      (cond
        [(and (null? q) (null? p)) #t]
        [(null? q) #f]
        [(null? p) (if (string->list (string-upcase (car q))) 
                       (if (string-upcase (car q)) #f #t) #t)]
        [(char=? (car p) (car q)) (helper (cdr q) (cdr p))]
        [(char=? (car p) (string-upcase (car q))) (or (helper (cdr q) (cdr p)) (helper (cdr q) p))]
        [(char<? (car p) (car q)) #f]
        [else (helper (cdr q) p)]))
    (helper (string->list query) (string->list pattern)))

  (map (lambda (query) (match query pattern)) queries))