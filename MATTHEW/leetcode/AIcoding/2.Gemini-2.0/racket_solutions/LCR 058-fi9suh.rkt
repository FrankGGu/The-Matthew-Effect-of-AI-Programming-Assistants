(define (my-calendar)
  (let ([calendar '()])
    (define (book start end)
      (let loop ([cal calendar])
        (cond
          [(null? cal)
           (set! calendar (cons (cons start end) calendar))
           #t]
          [else
           (let* ([event (car cal)]
                  [event-start (car event)]
                  [event-end (cdr event)])
             (cond
               [(<= start event-start)
                (if (<= end event-start)
                    (loop (cdr cal))
                    #f)]
               [(<= event-start start)
                (if (<= event-end start)
                    (loop (cdr cal))
                    #f)]
               [else #f]))]))))
    (lambda (start end)
      (book start end))))