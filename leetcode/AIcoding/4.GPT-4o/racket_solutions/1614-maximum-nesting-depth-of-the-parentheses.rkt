(define (maxNestingDepth s)
  (define (helper chars depth max)
    (cond
      ((null? chars) max)
      ((equal? (car chars) #\() (helper (cdr chars) (+ depth 1) (max (+ depth 1) max)))
      ((equal? (car chars) #\)) (helper (cdr chars) (- depth 1) max))
      (else (helper (cdr chars) depth max))))
  (helper (string->list s) 0 0))