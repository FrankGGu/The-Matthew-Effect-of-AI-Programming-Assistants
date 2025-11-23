(define (getDecimalValue head)
  (define (helper node acc)
    (if (null? node)
        acc
        (helper (cdr node) (+ (* acc 2) (car node)))))
  (helper head 0))