(define (remove-adjacent s)
  (let loop ([s (string->list s)] [stack '()])
    (cond
      [(null? s) (list->string (reverse stack))]
      [(and (not (null? stack)) (char=? (car s) (car stack)))
       (loop (cdr s) (cdr stack))]
      [else (loop (cdr s) (cons (car s) stack))])))