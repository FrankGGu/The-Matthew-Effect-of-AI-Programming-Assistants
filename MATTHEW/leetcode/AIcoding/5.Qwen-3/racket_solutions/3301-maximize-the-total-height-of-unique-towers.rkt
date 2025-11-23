#lang racket

(define (maximize-height towers)
  (define (helper towers height)
    (cond [(null? towers) height]
          [else
           (let ([t (car towers)])
             (if (member t (cdr towers))
                 (helper (cdr towers) height)
                 (helper (cdr towers) (+ height t))))]))
  (helper towers 0))