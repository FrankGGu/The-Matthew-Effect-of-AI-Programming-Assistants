#lang racket

(define (total-characters-after-transformations s)
  (for/sum ([c (in-string s)])
    (cond
      [(char-numeric? c)
       (- (char->integer c) (char->integer #\0))]
      [(char-lower-case? c)
       (+ 1 (- (char->integer c) (char->integer #\a)))]
      [else 0])))