(define (can-cut grid)
  (define (check-row row)
    (and (or (equal? row #\A) (equal? row #\B))
         (not (equal? row #\C))))

  (define (check-column col)
    (and (or (equal? col #\A) (equal? col #\B))
         (not (equal? col #\C))))

  (define (valid-section? grid)
    (for/all ([i (in-range (length grid))])
      (check-row (list-ref grid i)))
    (for/all ([j (in-range (length (list-ref grid 0)))])
      (check-column (map (lambda (row) (list-ref row j)) grid))))

  (valid-section? grid))