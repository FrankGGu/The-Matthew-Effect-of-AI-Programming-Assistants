#lang racket

(define (min-add-to-make-valid s)
  (define (helper s left right)
    (cond [(null? s) (abs (- left right))]
          [(char=? #\() (helper (cdr s) (+ left 1) right)]
          [else
           (if (> left 0)
               (helper (cdr s) (- left 1) (+ right 1))
               (helper (cdr s) left (+ right 1)))]))
  (helper (string->list s) 0 0))