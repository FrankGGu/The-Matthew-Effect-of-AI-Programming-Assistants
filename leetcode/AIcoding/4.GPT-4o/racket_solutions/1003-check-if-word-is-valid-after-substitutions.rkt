(define (is-valid s)
  (define (helper s stack)
    (cond
      [(null? s) (null? stack)]
      [(equal? (car s) #\c)
       (if (and (>= (length stack) 2)
                (equal? (car stack) #\b)
                (equal? (cadr stack) #\a))
           (helper (cdr s) (cddr stack))
           (helper (cdr s) (cons (car s) stack)))]
      [else (helper (cdr s) (cons (car s) stack))]))
  (helper (string->list s) '()))

(define (check-valid-word s)
  (is-valid s))