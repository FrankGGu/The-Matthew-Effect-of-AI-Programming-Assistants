(define (make-strings-equal s t)
  (let* ([n (string-length s)]
         [s-has-one? (ormap (lambda (c) (equal? c #\1)) (string->list s))]
         [t-has-one? (ormap (lambda (c) (equal? c #\1)) (string->list t))])
    (cond
      [(equal? s t) #t]
      [(and s-has-one? t-has-one?) #t]
      [else #f])))