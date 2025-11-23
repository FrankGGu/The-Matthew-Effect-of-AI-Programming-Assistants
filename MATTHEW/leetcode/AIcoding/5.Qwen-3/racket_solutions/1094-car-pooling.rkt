#lang racket

(define (car-pooling trips)
  (define (compare a b)
    (< (car a) (car b)))
  (define (process-trips trips)
    (cond [(null? trips) '()]
          [else
           (let* ([trip (car trips)]
                  [start (cadr trip)]
                  [end (caddr trip)]
                  [passengers (car trip)])
             (append (list (cons start passengers))
                     (list (cons end (- passengers)))
                     (process-trips (cdr trips))))]))
  (define sorted (sort (process-trips trips) compare))
  (define (helper lst current)
    (cond [(null? lst) #t]
          [else
           (if (>= current (cdar lst))
               (helper (cdr lst) (+ current (cdar lst)))
               #f)]))
  (helper sorted 0))