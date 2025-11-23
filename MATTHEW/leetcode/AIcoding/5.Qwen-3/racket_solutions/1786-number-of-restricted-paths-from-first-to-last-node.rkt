#lang racket

(define (num-unique-guests guests)
  (define (helper lst seen)
    (cond [(null? lst) 0]
          [(member (car lst) seen) (helper (cdr lst) seen)]
          [else (+ 1 (helper (cdr lst) (cons (car lst) seen)))]))
  (helper guests '()))

(define (main)
  (define input (read-line))
  (define guests (map string->number (string-split input)))
  (display (num-unique-guests guests)))

(main)