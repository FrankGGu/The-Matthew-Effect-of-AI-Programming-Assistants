#lang racket

(define (minimal-execution-time root)
  (define (helper node)
    (if (null? node)
        (cons 0 0)
        (let* ([left (helper (car node))]
               [right (helper (cdr node))]
               [total (+ (car left) (car right))]
               [max-serial (max (cdr left) (cdr right))])
          (cons (+ (car left) (car right))
                (if (<= total max-serial)
                    (* 2 max-serial)
                    (+ total (if (odd? (- total max-serial)) 1 0)))))))
  (cdr (helper root)))