(define (is-valid-bst root)
  (define (helper node min max)
    (cond
      [(null? node) #t]
      [(and (or (null? min) (< min (car node)))
            (or (null? max) (> max (car node))))
       (and (helper (cadr node) min (car node))
            (helper (caddr node) (car node) max))]
      [else #f]))
  (helper root null null))