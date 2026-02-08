(define (minimum-length s)
  (let loop ([s (string->list s)])
    (cond
      [(null? s) 0]
      [(null? (cdr s)) (length s)]
      [(equal? (car s) (cadr s)) (loop (cddr s))]
      [else (length s)])))