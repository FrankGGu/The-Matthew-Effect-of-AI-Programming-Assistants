(define (squareIsWhite coordinates)
  (let* ((x (string->number (string (string-ref coordinates 0))))
         (y (string->number (string (string-ref coordinates 1)))))
    (even? (+ x y))))