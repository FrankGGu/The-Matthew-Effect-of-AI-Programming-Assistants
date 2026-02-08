(define (generate-the-string n)
  (if (odd? n)
      (apply string (make-list n #\a))
      (apply string (make-list (- n 1) #\a) (list #\b))))