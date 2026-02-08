(define-struct my-calendar (events) #:mutable)

(define (my-calendar)
  (make-my-calendar '()))

(define (my-calendar-book mc start end)
  (let ((current-events (my-calendar-events mc)))
    (if (ormap (lambda (event)
                 (let ((b-start (car event))
                       (b-end (cadr event)))
                   (and (< start b-end)
                        (< b-start end))))
               current-events)
        #f
        (begin
          (set-my-calendar-events! mc (cons (list start end) current-events))
          #t))))