(define (remove-stars s)
  (let loop ([s (string->list s)] [acc '()])
    (cond
      [(empty? s) (list->string (reverse acc))]
      [(equal? (car s) #\*) (loop (cdr s) (cdr acc))]
      [else (loop (cdr s) (cons (car s) acc))])))