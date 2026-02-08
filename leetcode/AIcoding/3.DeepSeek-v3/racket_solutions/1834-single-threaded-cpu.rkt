(define (get-order tasks)
  (define n (length tasks))
  (define indexed-tasks (for/list ([task tasks] [i (in-naturals)]) (cons i task)))
  (define (available-tasks current-time remaining-tasks)
    (filter (λ (task) (<= (cadr task) current-time)) remaining-tasks))
  (define (next-task current-time remaining-tasks)
    (let ([avail (available-tasks current-time remaining-tasks)])
      (if (null? avail)
          (values #f #f)
          (let* ([min-task (argmin (λ (t) (cons (caddr t) (car t))) avail)])
            (values min-task (remove min-task remaining-tasks))))))
  (let loop ([current-time 0]
             [remaining-tasks indexed-tasks]
             [result '()])
    (if (null? remaining-tasks)
        (reverse result)
        (let-values ([(task new-remaining) (next-task current-time remaining-tasks)])
          (if task
              (let ([processing-time (caddr task)])
                (loop (+ current-time processing-time)
                      new-remaining
                      (cons (car task) result)))
              (let ([next-available-time (apply min (map cadr remaining-tasks))])
                (loop next-available-time
                      remaining-tasks
                      result)))))))