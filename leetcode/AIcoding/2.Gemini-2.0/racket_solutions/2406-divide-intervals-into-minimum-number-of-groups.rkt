(define (min-groups intervals)
  (define events (sort (append (map (lambda (interval) (list (car interval) #t)) intervals)
                               (map (lambda (interval) (list (cadr interval) #f)) intervals))
                       < #:key car))
  (define (solve events active)
    (cond [(empty? events) active]
          [else
           (let* ([event (car events)]
                  [time (car event)]
                  [is-start (cadr event)])
             (if is-start
                 (solve (cdr events) (+ active 1))
                 (solve (cdr events) (- active 1))))]))
  (solve events 0))