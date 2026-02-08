(define (rob root)
  (define (rob-helper node)
    (cond
      [(null? node) (cons 0 0)]
      [else
       (define left (rob-helper (car node)))
       (define right (rob-helper (cdr node)))
       (define rob-current (+ (car (car node)) (cdr left) (cdr right)))
       (define skip-current (+ (max (car left) (cdr left)) (max (car right) (cdr right))))
       (cons rob-current skip-current)]))
  (define result (rob-helper root))
  (max (car result) (cdr result)))