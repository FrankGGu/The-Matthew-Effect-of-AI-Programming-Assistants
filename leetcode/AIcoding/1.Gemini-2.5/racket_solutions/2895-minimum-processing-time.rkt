(define (minimum-processing-time processorTime tasks)
  (define sorted-processors (sort processorTime <))
  (define sorted-tasks (sort tasks >))

  (define (calculate-max-time procs tasks-remaining acc)
    (if (empty? procs)
        (apply max acc)
        (let* ([p (car procs)]
               [t (car tasks-remaining)]
               [current-max-time (+ p t)])
          (calculate-max-time (cdr procs)
                              (drop tasks-remaining 4)
                              (cons current-max-time acc)))))

  (calculate-max-time sorted-processors sorted-tasks '()))