(define (clear-stars s)
  (let loop ([chars (string->list s)]
             [stack '()])
    (cond
      [(null? chars) (list->string (reverse stack))]
      [(char=? (car chars) #\*)
       (if (null? stack)
           (loop (cdr chars) stack)
           (loop (cdr chars) (cdr stack)))]
      [else
       (loop (cdr chars) (cons (car chars) stack))])))