#lang racket

(define (transform-string s n)
  (define (transform c)
    (if (char<=? c #\z)
        (integer->char (+ (char->integer c) n))
        c))
  (define transformed (map transform (string->list s)))
  (string-append (list->string transformed) (if (string-empty? s) "" " ")))

(define (total-characters s n)
  (string-length (transform-string s n)))

(define (main)
  (define input (read-line))
  (define n (read))
  (display (total-characters input n)))

(main)