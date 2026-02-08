(define (optimal-division nums)
  (let* ((n (length nums))
         (num-strings (map number->string nums)))
    (cond
      ((= n 1) (car num-strings))
      ((= n 2) (string-append (car num-strings) "/" (cadr num-strings)))
      (else
       (string-append
        (car num-strings)
        "/("
        (string-join (cdr num-strings) "/")
        ")")))))