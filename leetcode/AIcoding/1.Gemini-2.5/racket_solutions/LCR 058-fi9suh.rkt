#lang racket

(struct my-calendar (#[mutable] events))

(define (my-calendar%)
  (my-calendar '()))

(define (my-calendar-book mc start end)
  (let ([current-events (my-calendar-events mc)])
    (define (overlaps? s1 e1 s2 e2)
      (and (< s1 e2)
           (< s2 e1)))

    (define (check-all-overlaps events-list)
      (cond
        [(empty? events-list) #f]
        [else
         (let* ([event (first events-list)]
                [s_old (first event)]
                [e_old (second event)])
           (if (overlaps? s_old e_old start end)
               #t
               (check-all-overlaps (rest events-list))))]))

    (if (check-all-overlaps current-events)
        #f
        (begin
          (set-my-calendar-events! mc (cons (list start end) current-events))
          #t))))