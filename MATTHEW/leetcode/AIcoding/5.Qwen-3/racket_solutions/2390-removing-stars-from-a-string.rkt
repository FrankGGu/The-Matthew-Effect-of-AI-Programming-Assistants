#lang racket

(define (remove-stars s)
  (define (loop s res)
    (cond [(empty? s) (list->string (reverse res))]
          [(char=? (car s) #\*)
           (loop (cdr s) (cdr res))]
          [else
           (loop (cdr s) (cons (car s) res))]))
  (loop (string->list s) '()))