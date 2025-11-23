(define (min-insertions s)
  (let loop ([s (string->list s)]
             [i 0])
    (cond
      [(null? s) i]
      [(equal? (car s) #\a)
       (loop (cdr s) i)]
      [(equal? (car s) #\b)
       (if (null? (cdr s))
           (+ i 1)
           (if (equal? (cadr s) #\c)
               (loop (cddr s) i)
               (loop (cdr s) (+ i 1))))]
      [(equal? (car s) #\c)
       (error "Invalid input")])))

(provide min-insertions)