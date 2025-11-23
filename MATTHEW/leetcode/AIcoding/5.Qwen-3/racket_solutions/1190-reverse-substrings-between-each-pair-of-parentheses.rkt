#lang racket

(define (reverse-substrings-between-each-parentheses s)
  (define (helper s stack)
    (cond [(null? s) (list->string (reverse stack))]
          [(char=? #\() (let ([sub (helper (cdr s) '())])
                          (helper (reverse (string->list sub)) stack))]
          [(char=? #\)) (let ([sub (reverse stack)])
                          (list->string sub))]
          [else (helper (cdr s) (cons (car s) stack))]))
  (helper (string->list s) '()))