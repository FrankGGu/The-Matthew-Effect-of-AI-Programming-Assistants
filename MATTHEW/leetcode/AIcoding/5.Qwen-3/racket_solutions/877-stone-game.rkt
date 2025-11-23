#lang racket

(define (stone-game p)
  (let loop ([p p] [a 0] [b 0])
    (cond
      [(null? p) (>= a b)]
      [else
       (if (even? (length p))
           (loop (cdr p) a (+ b (car p)))
           (loop (cdr p) (+ a (car p)) b))])))