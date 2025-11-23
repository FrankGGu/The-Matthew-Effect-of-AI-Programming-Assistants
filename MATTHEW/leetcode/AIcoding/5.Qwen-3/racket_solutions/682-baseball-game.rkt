#lang racket

(define (cal-points ops)
  (define (apply-op op stack)
    (cond [(equal? op "C") (cdr stack)]
          [(equal? op "D") (cons (* 2 (car stack)) stack)]
          [(equal? op "+") (cons (+ (car stack) (cadr stack)) stack)]
          [else (cons (string->number op) stack)]))
  (foldl apply-op '() ops))