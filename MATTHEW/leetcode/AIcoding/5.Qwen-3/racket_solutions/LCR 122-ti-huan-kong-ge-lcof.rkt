#lang racket

(define (path-encryption s)
  (define (encrypt c)
    (if (char-alphabetic? c)
        (integer->char (+ 122 (- (char->integer c) 97)))
        c))
  (list->string (map encrypt (string->list s))))