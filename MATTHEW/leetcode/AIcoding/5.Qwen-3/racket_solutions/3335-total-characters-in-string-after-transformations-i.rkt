#lang racket

(define/contract (sum-letters s)
  (-> string? exact-integer?)
  (define (transform c)
    (cond [(char=? c #\a) 1]
          [(char=? c #\b) 2]
          [(char=? c #\c) 3]
          [else 0]))
  (for/sum ([c (in-string s)])
    (transform c)))