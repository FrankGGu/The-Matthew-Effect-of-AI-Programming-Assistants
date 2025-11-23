(define (flatten root)
  (define (flatten-helper root)
    (cond
      [(null? root) (values null null)]
      [(and (null? (cdr root)) (null? (car root))) (values root root)]
      [(null? (car root))
       (let-values ([(head tail) (flatten-helper (cdr root))])
         (set-cdr! root (cdr root))
         (set-car! root null)
         (values root tail))]
      [(null? (cdr root))
       (let-values ([(head tail) (flatten-helper (car root))])
         (set-cdr! tail (cdr root))
         (set-cdr! root (car root))
         (set-car! root null)
         (values root tail))]
      [else
       (let-values ([(left-head left-tail) (flatten-helper (car root))])
         (let-values ([(right-head right-tail) (flatten-helper (cdr root))])
           (set-cdr! left-tail (cdr root))
           (set-cdr! root (car root))
           (set-car! root null)
           (values root right-tail)))]))
  (if (not (null? root))
      (flatten-helper root)
      null))