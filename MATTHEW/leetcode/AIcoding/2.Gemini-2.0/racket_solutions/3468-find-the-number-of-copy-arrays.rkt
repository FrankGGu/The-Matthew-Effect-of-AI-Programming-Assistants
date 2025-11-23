(define (find-max-equal-rows matrix)
  (define (count-equal-rows row)
    (define (helper rows count)
      (cond
        [(empty? rows) count]
        [(equal? row (car rows)) (helper (cdr rows) (+ 1 count))]
        [else (helper (cdr rows) count)]))
    (helper matrix 0))

  (if (empty? matrix)
      0
      (apply max (map count-equal-rows matrix))))