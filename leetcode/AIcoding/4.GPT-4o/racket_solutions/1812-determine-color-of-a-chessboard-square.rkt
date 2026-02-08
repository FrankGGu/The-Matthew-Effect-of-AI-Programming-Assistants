(define (squareIsWhite coordinates)
  (let* ((col (string->number (string (char-ref coordinates 0))))
         (row (string->number (string (char-ref coordinates 1)))))
    (odd? (+ col row))))