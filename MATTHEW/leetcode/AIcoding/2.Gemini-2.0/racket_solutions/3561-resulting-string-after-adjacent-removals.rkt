(define (remove-adjacent-duplicates s)
  (let loop ([stack '()] [str (string->list s)])
    (cond
      [(empty? str) (list->string (reverse stack))]
      [(empty? stack) (loop (list (car str)) (cdr str))]
      [(equal? (car str) (car stack)) (loop (cdr stack) (cdr str))]
      [else (loop (cons (car str) stack) (cdr str))])))