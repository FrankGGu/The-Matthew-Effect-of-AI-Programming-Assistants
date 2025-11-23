#lang racket

(define (find-matching-queries queries pattern)
  (define (match? q p)
    (cond [(and (null? q) (null? p)) #t]
          [(or (null? q) (null? p)) #f]
          [else (and (equal? (car q) (car p))
                     (match? (cdr q) (cdr p)))]))
  (filter (lambda (q) (match? q pattern)) queries))