(define (minimum-time root)
  (define (helper node)
    (cond
      [(null? node) (values 0 0)]
      [else
       (let-values ([(left-sum left-max) (helper (car node))]
                      [(right-sum right-max) (helper (cadr node))])
         (let [(curr-time (if (null? (cddr node)) 0 (caddr node)))]
           (values (+ curr-time left-sum right-sum)
                   (+ curr-time (max left-max right-max)))))]))
  (let-values ([(total-time max-time) (helper root)])
    max-time))