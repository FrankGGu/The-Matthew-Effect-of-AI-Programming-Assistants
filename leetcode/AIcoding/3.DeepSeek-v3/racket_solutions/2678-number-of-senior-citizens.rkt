(define (count-seniors details)
  (length
   (filter
    (lambda (s)
      (> (string->number (substring s 11 13)) 60))
    details)))