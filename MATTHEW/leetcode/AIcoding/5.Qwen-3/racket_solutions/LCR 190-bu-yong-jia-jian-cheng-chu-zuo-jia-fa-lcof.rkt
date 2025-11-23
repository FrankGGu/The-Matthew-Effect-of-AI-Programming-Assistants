#lang racket

(define (encrypt num)
  (define (digit->char d)
    (integer->char (+ 48 d)))
  (define (char->digit c)
    (- (char->integer c) 48))
  (define digits (map char->digit (string->list (number->string num))))
  (define encrypted-digits (map (lambda (d) (if (= d 9) 0 (+ d 1))) digits))
  (string->number (apply string (map digit->char encrypted-digits))))

(define (decrypt num)
  (define (digit->char d)
    (integer->char (+ 48 d)))
  (define (char->digit c)
    (- (char->integer c) 48))
  (define digits (map char->digit (string->list (number->string num))))
  (define decrypted-digits (map (lambda (d) (if (= d 0) 9 (- d 1))) digits))
  (string->number (apply string (map digit->char decrypted-digits))))