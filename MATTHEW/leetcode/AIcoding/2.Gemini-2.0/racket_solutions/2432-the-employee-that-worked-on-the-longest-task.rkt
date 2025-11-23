(define (longest-task logs)
  (let loop ([logs logs]
             [max-time 0]
             [employee -1]
             [start-time 0])
    (cond
      [(null? logs) employee]
      [else
       (let ([current-employee (caar logs)]
             [current-end-time (cadar logs)]
             [duration (- current-end-time start-time)])
         (loop (cdr logs)
               (if (> duration max-time)
                   duration
                   max-time)
               (if (> duration max-time)
                   current-employee
                   (if (= duration max-time)
                       (min current-employee employee)
                       employee))
               current-end-time))])))