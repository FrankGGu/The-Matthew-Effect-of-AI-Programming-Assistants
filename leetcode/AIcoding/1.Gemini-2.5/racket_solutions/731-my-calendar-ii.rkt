#lang racket

(define (interval-overlap? i1 i2)
  (let ((s1 (car i1)) (e1 (cadr i1))
        (s2 (car i2)) (e2 (cadr i2)))
    (< (max s1 s2) (min e1 e2))))

(define (get-overlap-interval i1 i2)
  (let ((s1 (car i1)) (e1 (cadr i1))
        (s2 (car i2)) (e2 (cadr i2)))
    (let ((overlap-start (max s1 s2))
          (overlap-end (min e1 e2)))
      (if (< overlap-start overlap-end)
          (list overlap-start overlap-end)
          #f))))

(define (MyCalendarTwo)
  (let ((single-bookings '())
        (double-bookings '()))

    (define (book start end)
      (let* ((new-event (list start end)))

        (if (ormap (lambda (db-event) (interval-overlap? new-event db-event))
                   double-bookings)
            #f
            (begin
              (let ((newly-double-booked-intervals '()))
                (for-each (lambda (sb-event)
                            (let ((overlap (get-overlap-interval new-event sb-event)))
                              (when overlap
                                (set! newly-double-booked-intervals (cons overlap newly-double-booked-intervals)))))
                          single-bookings)

                (set! double-bookings (append double-bookings newly-double-booked-intervals))

                (set! single-bookings (cons new-event single-bookings))

                #t))))

    (lambda (message . args)
      (case message
        ((book) (apply book args))))))