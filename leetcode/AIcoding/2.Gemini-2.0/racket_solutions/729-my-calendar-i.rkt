(define MyCalendar%
  (class object%
    (init)
    (define events '())

    (define/public (book start end)
      (let loop ((events events))
        (cond
          [(null? events)
           (set! events (cons (cons start end) events))
           #t]
          [else
           (let ((event (car events)))
             (let ((s (car event)) (e (cdr event)))
               (cond
                 [(= s end) (loop (cdr events))]
                 [(= start e) (loop (cdr events))]
                 [(or (> start e) (< end s)) (loop (cdr events))]
                 [else #f])))])))
    ))

(define (make-MyCalendar)
  (new MyCalendar%))