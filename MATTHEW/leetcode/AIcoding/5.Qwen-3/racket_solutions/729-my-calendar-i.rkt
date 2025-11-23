#lang racket

(define-struct interval (start end))

(define (my-calendar-I)
  (let ((intervals '()))
    (lambda (start end)
      (define (overlap? new-interval)
        (for/or ([i intervals])
          (and (< (interval-start new-interval) (interval-end i))
               (> (interval-end new-interval) (interval-start i)))))
      (if (overlap? (make-interval start end))
          #f
          (begin
            (set! intervals (cons (make-interval start end) intervals))
            #t)))))

(define my-calendar (my-calendar-I))