(define (rob root)
  (define (helper node)
    (if (not node)
        (values 0 0)
        (let* ([left (helper (car node))]
               [right (helper (cadr node))]
               [not-rob (max (car left) (cdr left) (car right) (cdr right))]
               [rob (+ (cadr node) (car left) (car right))])
          (values not-rob rob))))
  (car (helper root)))