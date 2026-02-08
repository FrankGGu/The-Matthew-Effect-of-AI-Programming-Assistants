(define (deleteDuplicates head)
  (define (helper node prev)
    (cond
      [(null? node) prev]
      [(and (null? (cdr node)) (null? prev)) node]
      [(and (equal? (car node) (car (cdr node)))
            (or (null? prev) (not (equal? (car node) (car prev)))))
       (helper (cdr node) prev)]
      [(and (equal? (car node) (car (cdr node)))
            (equal? (car node) (car prev)))
       (helper (cdr node) prev)]
      [else
       (helper (cdr node) (cons (car node) prev))]))
  (define result (helper head '()))
  (if (null? result)
      '()
      (reverse result)))