(define (valid-emails emails)
  (string-join
   (filter
    (lambda (email)
      (regexp-match? #rx"^[a-zA-Z][a-zA-Z0-9_.-]*@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z]{2,}$" email))
    emails)
   "\n"))