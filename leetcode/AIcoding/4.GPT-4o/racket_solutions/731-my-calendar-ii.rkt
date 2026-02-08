(define MyCalendarTwo
  (class object%
    (super-new)

    (define/override (book start end)
      (let loop ((i 0) (events (list)))
        (cond
          ((= i (length events)) 
           (begin
             (set! events (cons (list start end) events))
             #t))
          (else
           (let ((event (list-ref events i)))
             (if (or (>= start (second event)) (>= (first event) end))
                 (loop (+ i 1) events)
                 (if (> (length (filter (lambda (x) (and (<= (first x) end) (>= (second x) start))) events)) 1)
                     #f
                     (loop (+ i 1) events)))))))))

    (define (initialize) (void))
    (super-new)))

(define my-calendar (new MyCalendarTwo))
(define (book start end) (send my-calendar book start end))