(define (robot-with-string s)
  (let loop ([s (string->list s)]
             [t '()]
             [res '()])
    (cond
      [(and (null? s) (null? t)) (list->string (reverse res))]
      [(null? s) (loop s (cdr t) (cons (car t) res))]
      [(null? t) (loop (cdr s) (cons (car s) t) res)]
      [(char<=? (car t) (car s)) (loop s (cdr t) (cons (car t) res)]
      [else (loop (cdr s) (cons (car s) t) res)])))