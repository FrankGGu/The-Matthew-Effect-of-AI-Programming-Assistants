(define (max-equal-rows-after-flips matrix)
  (define (normalize row)
    (if (equal? (first row) 0)
        row
        (map (lambda (x) (if (equal? x 0) 1 0)) row)))

  (define normalized-matrix (map normalize matrix))

  (define (count-equal-rows row matrix)
    (length (filter (lambda (r) (equal? r row)) matrix)))

  (apply max (map (lambda (row) (count-equal-rows row normalized-matrix)) normalized-matrix)))