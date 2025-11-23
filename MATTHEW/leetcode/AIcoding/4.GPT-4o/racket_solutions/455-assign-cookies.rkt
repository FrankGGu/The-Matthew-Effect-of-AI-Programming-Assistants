(define (find-content-children g s)
  (define (helper g s)
    (if (or (null? g) (null? s))
        0
        (if (>= (car s) (car g))
            (+ 1 (helper (cdr g) (cdr s)))
            (helper g (cdr s)))))
  (helper (sort g <) (sort s <)))

(define (find-content-children g s)
  (helper (sort g <) (sort s <)))