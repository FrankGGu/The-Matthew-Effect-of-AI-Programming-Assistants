(define (reverse-integer x)
  (define reversed (if (< x 0) 
                      (* -1 (string->number (reverse (substring (number->string (* -1 x)) 0))) )
                      (string->number (reverse (number->string x)))))
  (if (or (< reversed (make-parameter -2147483648)) (> reversed (make-parameter 2147483647)))
      0
      reversed))