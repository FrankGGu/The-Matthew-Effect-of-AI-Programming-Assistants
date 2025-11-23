(define (destroy-sequential-targets targets)
  (define (destroy-helper targets count)
    (if (null? targets)
        count
        (let ([current (car targets)]
              [next (if (null? (cdr targets)) '() (cadr targets))])
          (if (and (equal? current next) (not (null? next)))
              (destroy-helper (cddr targets) (+ count 1))
              (destroy-helper (cdr targets) count)))))
  (destroy-helper targets 0))