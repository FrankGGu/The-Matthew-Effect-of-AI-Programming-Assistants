#lang racket

(define (minimum-time-to-type word)
  (define (distance a b)
    (min (abs (- a b)) (+ 26 (abs (- a b)))))
  (define (helper c prev)
    (if (null? c)
        0
        (+ (distance prev (char->integer (car c)))
           (helper (cdr c) (char->integer (car c))))))
  (helper (string->list word) 0))