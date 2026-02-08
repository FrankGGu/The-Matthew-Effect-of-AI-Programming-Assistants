(define (task-scheduler-ii tasks space)
  (let ([current-day 0]
        [last-seen (make-hash)])
    (for-each (lambda (task)
                (set! current-day (+ current-day 1))
                (when (hash-has-key? last-seen task)
                  (let ([last-completion-day (hash-ref last-seen task)]
                        [earliest-available-day (+ last-completion-day space 1)])
                    (when (< current-day earliest-available-day)
                      (set! current-day earliest-available-day))))
                (hash-set! last-seen task current-day))
    current-day))