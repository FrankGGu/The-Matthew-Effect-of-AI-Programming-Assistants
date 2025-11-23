(define (maxAncestorDiff root)
  (define (helper node min-val max-val)
    (cond
      [(null? node) (- max-val min-val)]
      [else
       (let* ([new-min (min min-val (car node))]
              [new-max (max max-val (car node))])
         (max (helper (cadr node) new-min new-max)
              (helper (caddr node) new-min new-max)))]))

  (helper root (car root) (car root)))