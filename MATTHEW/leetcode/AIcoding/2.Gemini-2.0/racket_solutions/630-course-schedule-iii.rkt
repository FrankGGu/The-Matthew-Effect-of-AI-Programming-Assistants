(define (schedule-course courses)
  (define sorted-courses (sort courses (lambda (a b) (< (cadr a) (cadr b)))))
  (define heap (make-heap < #:key car))
  (define (helper courses current-time)
    (cond
      [(null? courses) (heap-count heap)]
      [else
       (let* ([course (car courses)]
              [duration (car course)]
              [deadline (cadr course)])
         (if (<= (+ current-time duration) deadline)
             (begin
               (heap-add! heap duration)
               (helper (cdr courses) (+ current-time duration)))
             (if (and (not (heap-empty? heap)) (> duration (heap-top heap)))
                 (begin
                   (define top (heap-top heap))
                   (heap-remove-top! heap)
                   (heap-add! heap duration)
                   (helper (cdr courses) (+ current-time duration (- top))))
                 (helper (cdr courses) current-time))))]))
  (helper sorted-courses 0))