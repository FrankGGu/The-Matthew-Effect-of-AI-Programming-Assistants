(define (max-strength ranges)
  (define events (sort (append (map (lambda (r) (list (car r) 1)) ranges)
                              (map (lambda (r) (list (cdr r) -1)) ranges))
                      < #:key car))
  (define (helper events current-strength max-strength)
    (cond
      [(empty? events) max-strength]
      [else
       (let* ([event (car events)]
              [new-strength (+ current-strength (cadr event))])
         (helper (cdr events) new-strength (max max-strength new-strength)))]))
  (helper events 0 0))