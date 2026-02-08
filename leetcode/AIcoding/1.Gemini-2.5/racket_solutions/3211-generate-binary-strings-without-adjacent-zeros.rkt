(define (solve n)
  (define (generate-strings current-prefix last-char-was-zero?)
    (if (= (length current-prefix) n)
        (list (list->string (reverse current-prefix)))
        (append
         (generate-strings (cons #\1 current-prefix) #f)
         (if (not last-char-was-zero?)
             (generate-strings (cons #\0 current-prefix) #t)
             '()))))

  (if (= n 0)
      (list "")
      (append
       (generate-strings (list #\0) #t)
       (generate-strings (list #\1) #f))))