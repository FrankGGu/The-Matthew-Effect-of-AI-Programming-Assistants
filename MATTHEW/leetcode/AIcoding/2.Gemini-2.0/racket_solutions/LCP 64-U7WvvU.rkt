(define (tree-lights root)
  (define (helper node)
    (cond
      [(null? node) (values 0 0)]
      [else
       (define-values (left-on left-off) (helper (car node)))
       (define-values (right-on right-off) (helper (cadr node)))
       (values (+ 1 left-off right-off)
               (+ (min left-on left-off) (min right-on right-off)))]))
  (define-values (on off) (helper root))
  (min on off))