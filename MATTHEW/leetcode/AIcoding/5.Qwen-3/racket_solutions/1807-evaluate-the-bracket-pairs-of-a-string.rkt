#lang racket

(define (evaluate s)
  (define (helper stack)
    (cond [(null? s) (reverse (car stack))]
          [(char=? #\{ (string-ref s 0))
           (helper (cons (list (string-ref s 0)) (cdr stack)))]
          [(char=? #\} (string-ref s 0))
           (let* ([last (car stack)]
                  [rest (cdr stack)]
                  [value (if (and (pair? last) (char=? #\{ (car last)))
                             (cadr last)
                             (apply string-append (reverse last)))]
                  [new-stack (cons (list value) rest)])
             (helper new-stack))]
          [else
           (helper (cons (cons (string-ref s 0) (car stack)) (cdr stack)))]))
  (define (process s)
    (if (null? s)
        ""
        (string-append (string (car s)) (process (cdr s)))))
  (process (helper '(())))