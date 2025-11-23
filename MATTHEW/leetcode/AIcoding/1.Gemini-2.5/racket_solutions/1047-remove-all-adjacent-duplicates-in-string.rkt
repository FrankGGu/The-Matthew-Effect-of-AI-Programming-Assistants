(define (remove-duplicates s)
  (let loop ((chars (string->list s))
             (stack '()))
    (cond
      ((empty? chars)
       (list->string (reverse stack)))
      ((and (not (empty? stack))
            (char=? (car stack) (car chars)))
       (loop (cdr chars) (cdr stack)))
      (else
       (loop (cdr chars) (cons (car chars) stack))))))