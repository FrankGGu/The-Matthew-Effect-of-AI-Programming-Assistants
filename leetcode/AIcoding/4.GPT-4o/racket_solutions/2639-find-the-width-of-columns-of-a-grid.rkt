(define (find-column-widths grid)
  (define (max-length col)
    (apply max (map string-length (map (lambda (row) (list-ref row col)) grid))))
  (map max-length (range (length (list-ref grid 0)))))