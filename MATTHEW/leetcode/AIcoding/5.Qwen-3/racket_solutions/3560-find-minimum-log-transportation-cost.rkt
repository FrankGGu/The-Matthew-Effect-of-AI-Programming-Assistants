#lang racket

(define (minimum-cost-to-transport log)
  (define (helper cost logs)
    (if (null? logs)
        cost
        (let* ([current (car logs)]
               [next (cadr logs)])
          (if (<= (cdr current) (cdr next))
              (helper (+ cost (cdr current)) (cdr logs))
              (helper (+ cost (cdr next)) (cons next (cdr logs)))))))
  (helper 0 log))