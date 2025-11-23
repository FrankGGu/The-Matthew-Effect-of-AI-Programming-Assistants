(define (getMaximumConsecutive coins)
  (define (loop coins current)
    (if (null? coins)
        current
        (let ((coin (car coins)))
          (if (<= coin current)
              (loop (cdr coins) (+ current coin))
              current))))
  (loop (sort coins <) 0))