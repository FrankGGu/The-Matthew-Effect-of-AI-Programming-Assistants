(define (fuzzy-search-validate pattern word)
  (define (match? p w)
    (cond
      [(and (null? p) (null? w)) #t]
      [(null? p) #f]
      [(null? w) #f]
      [(char=? (car p) (car w)) (match? (cdr p) (cdr w))]
      [(char=? (car p) #\?) (match? (cdr p) (cdr w))]
      [else (match? (cdr p) w)]))
  (match? (string->list pattern) (string->list word)))