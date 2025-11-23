(define (square-is-white coordinates)
  (let ((col (char->integer (string-ref coordinates 0)))
        (row (string->number (substring coordinates 1))))
    (if (even? row)
        (if (even? col)
            #t
            #f)
        (if (even? col)
            #f
            #t))))