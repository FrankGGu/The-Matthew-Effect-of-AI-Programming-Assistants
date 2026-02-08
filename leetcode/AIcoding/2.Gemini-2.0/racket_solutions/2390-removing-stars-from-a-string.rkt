(define (remove-stars s)
  (let loop ([chars (string->list s)]
             [result '()])
    (cond
      [(empty? chars) (list->string (reverse result))]
      [(equal? (car chars) #\*)
       (loop (cdr chars) (cdr result))]
      [else (loop (cdr chars) (cons (car chars) result))])))