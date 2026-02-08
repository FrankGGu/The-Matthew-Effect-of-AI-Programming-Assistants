(define (minRemoveToMakeValid s)
  (let loop ([chars (string->list s)] [stack '()])
    (cond
      [(empty? chars)
       (list->string (reverse stack))]
      [(char=? (car chars) #\A)
       (loop (cdr chars) (cons (car chars) stack))]
      [(char=? (car chars) #\B)
       (if (and (not (empty? stack)) (char=? (car stack) #\A))
           (loop (cdr chars) (cdr stack))
           (loop (cdr chars) (cons (car chars) stack)))]
      [(char=? (car chars) #\C)
       (loop (cdr chars) (cons (car chars) stack))]
      [(char=? (car chars) #\D)
       (if (and (not (empty? stack)) (char=? (car stack) #\C))
           (loop (cdr chars) (cdr stack))
           (loop (cdr chars) (cons (car chars) stack)))]
      [else
       (loop (cdr chars) (cons (car chars) stack))])))

(define (min-string-length-after-removing-substrings s)
  (string-length (minRemoveToMakeValid s)))