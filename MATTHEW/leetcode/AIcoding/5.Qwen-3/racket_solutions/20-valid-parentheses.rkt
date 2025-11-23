#lang racket

(define (valid-parentheses s)
  (define (helper stack chars)
    (cond [(null? chars) (null? stack)]
          [(member (car chars) '(#\( #\{ #\[]))
           (helper (cons (car chars) stack) (cdr chars))]
          [(and (not (null? stack))
                (let ([top (car stack)])
                  (or (and (char=? top #\() (char=? (car chars) #\)))
                      (and (char=? top #\{) (char=? (car chars) #\}))
                      (and (char=? top #\[) (char=? (car chars) #\])))))
           (helper (cdr stack) (cdr chars))]
          [else #f]))
  (helper '() (string->list s)))