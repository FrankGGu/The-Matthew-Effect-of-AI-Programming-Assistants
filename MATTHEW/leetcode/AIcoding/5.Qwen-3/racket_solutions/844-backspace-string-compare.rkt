#lang racket

(define (backspace s)
  (define (helper lst)
    (cond [(null? lst) '()]
          [(equal? (car lst) #\#)
           (if (null? (cdr lst))
               '()
               (helper (cdr (cdr lst))))]
          [else
           (cons (car lst) (helper (cdr lst)))]))
  (reverse (helper (reverse s))))

(define (backspace-compare s1 s2)
  (equal? (backspace s1) (backspace s2)))