(define (generate-the-string n)
  (if (odd? n)
      (make-string n #\a)
      (string-append (make-string (- n 1) #\a) "b")))