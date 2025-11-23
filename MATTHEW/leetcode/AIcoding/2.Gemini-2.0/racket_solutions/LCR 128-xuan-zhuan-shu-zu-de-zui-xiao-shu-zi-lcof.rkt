(define (check-if-exist inventory target)
  (cond
    [(empty? inventory) #f]
    [else (or (equal? (car inventory) target)
              (check-if-exist (cdr inventory) target))]))