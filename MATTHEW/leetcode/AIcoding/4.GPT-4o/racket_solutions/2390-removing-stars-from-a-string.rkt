(define (remove-stars s)
  (define (helper s acc)
    (cond
      [(null? s) (apply string-append (reverse acc))]
      [(equal? (car s) #\*) (if (null? acc) (helper (cdr s) acc) (helper (cdr s) (cdr acc)))]
      [else (helper (cdr s) (cons (car s) acc))]))
  (helper (string->list s) '()))

(define (solution s)
  (remove-stars s))