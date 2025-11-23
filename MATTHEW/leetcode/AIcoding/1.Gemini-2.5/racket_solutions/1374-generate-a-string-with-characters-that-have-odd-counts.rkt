(define (generate-the-string n)
  (cond
    ((odd? n)
     (make-string n #\a))
    (else
     (string-append (make-string (- n 1) #\a) "b"))))