(define (is-palindrome s)
  (define (alphanumeric? c)
    (or (char-alphabetic? c) (char-numeric? c)))

  (define (normalize s)
    (list->string
     (filter alphanumeric?
             (map char-downcase (string->list s)))))

  (define normalized (normalize s))
  (equal? normalized (list->string (reverse (string->list normalized)))))