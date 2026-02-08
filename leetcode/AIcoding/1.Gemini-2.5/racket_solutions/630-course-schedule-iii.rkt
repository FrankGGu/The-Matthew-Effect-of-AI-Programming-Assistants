#lang racket
(require data/heap)

(define (schedule-course courses)
  (define sorted-courses
    (sort courses (lambda (c1 c2) (< (cadr c1) (cadr c2)))))

  (define current-time 0)
  (define taken-durations (make-heap >))

  (for-each
   (lambda (course)
     (define duration (car course))
     (define last-day (cadr course))

     (cond
       [(<= (+ current-time duration) last-day)
        (set! current-time (+ current-time duration))
        (heap-add! taken-durations duration)]
       [else
        (when (and (not (heap-empty? taken-durations))
                   (> (heap-min taken-durations) duration))
          (define longest-taken-duration (heap-extract-min! taken-durations))
          (set! current-time (- current-time longest-taken-duration))
          (set! current-time (+ current-time duration))
          (heap-add! taken-durations duration))]))
   sorted-courses)

  (heap-count taken-durations))