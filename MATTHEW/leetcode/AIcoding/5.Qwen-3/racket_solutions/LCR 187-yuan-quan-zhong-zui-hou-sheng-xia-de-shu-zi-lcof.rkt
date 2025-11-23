#lang racket

(define (find-the-winner n k)
  (define (helper m)
    (if (= m 1)
        0
        (modulo (+ (helper (- m 1)) k) m)))
  (+ (helper n) 1))