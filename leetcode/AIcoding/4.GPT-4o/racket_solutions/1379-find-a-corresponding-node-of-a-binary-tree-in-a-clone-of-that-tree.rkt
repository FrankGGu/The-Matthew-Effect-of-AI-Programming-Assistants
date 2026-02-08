(define (getTargetCopy original cloned target)
  (define (helper node)
    (if (null? node)
        #f
        (if (eq? node target)
            cloned
            (or (helper (car node))
                (helper (cadr node))))))
  (helper original))