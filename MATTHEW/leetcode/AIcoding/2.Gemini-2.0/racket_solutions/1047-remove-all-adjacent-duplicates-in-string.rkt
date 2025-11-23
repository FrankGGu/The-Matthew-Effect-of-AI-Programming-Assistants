(define (remove-duplicates s)
  (let loop ([s (string->list s)] [stack '()])
    (cond
      [(empty? s) (list->string (reverse stack))]
      [(empty? stack) (loop (cdr s) (list (car s)))]
      [(equal? (car s) (car stack)) (loop (cdr s) (cdr stack))]
      [else (loop (cdr s) (cons (car s) stack))])))