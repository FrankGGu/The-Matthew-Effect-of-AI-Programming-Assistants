(define (smallest-string s)
  (let loop ([s (string->list s)]
             [stack '()])
    (cond
      [(null? s) (list->string (reverse stack))]
      [(null? stack) (loop (cdr s) (cons (car s) stack))]
      [(char>? (car s) (car stack)) (loop (cdr s) (cons (car s) stack))]
      [else (loop (cons (car s) (cdr s)) (cdr stack))])))