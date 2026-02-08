(define (sum-even-grandparent root)
  (letrec ([helper (lambda (node grandparent parent)
                     (cond
                       [(null? node) 0]
                       [else
                        (+ (if (and (not (null? grandparent)) (even? (car grandparent))) (car node) 0)
                           (helper (cadr node) parent node)
                           (helper (caddr node) parent node))]))])
    (helper root null null)))