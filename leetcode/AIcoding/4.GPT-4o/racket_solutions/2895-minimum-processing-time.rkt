(define (min-processing-time tasks)
  (define (helper tasks time)
    (if (null? tasks)
        time
        (let* ((task (car tasks))
               (next-time (+ time task)))
          (helper (cdr tasks) next-time))))
  (helper (sort tasks <) 0))

(min-processing-time '(3 1 2 4))