(define (generate-the-string n)
  (if (= (modulo n 2) 0)
      (string-append (make-string (- n 1) #\a) (string #\b))
      (make-string n #\a)))