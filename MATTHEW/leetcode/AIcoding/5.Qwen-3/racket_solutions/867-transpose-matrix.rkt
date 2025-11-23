(define (transpose matrix)
  (apply map list (apply map (lambda (row) (apply vector row)) matrix)))