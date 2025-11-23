#lang racket

(define (my-calendar-ii)
  (let ([events '()])
    (define (book start end)
      (let loop ([events events] [count 0])
        (cond [(null? events) #t]
              [(and (<= start (caar events)) (< (cdar events) end)) #f]
              [(and (>= start (caar events)) (< end (cdar events))) #f]
              [else (loop (cdr events) count)]))
      (if (andmap (lambda (e) (not (or (and (<= start (car e)) (< (cdr e) end))
                                      (and (>= start (car e)) (< end (cdr e))))))
                  events)
          (begin
            (set! events (cons (cons start end) events))
            #t)
          #f))
    (lambda (start end) (book start end))))