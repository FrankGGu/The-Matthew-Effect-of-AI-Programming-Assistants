#lang racket

(define (reverse-words s)
  (define (reverse-string str)
    (list->string (reverse (string->list str))))
  (string-join (map reverse-string (string-split s " ")) " "))