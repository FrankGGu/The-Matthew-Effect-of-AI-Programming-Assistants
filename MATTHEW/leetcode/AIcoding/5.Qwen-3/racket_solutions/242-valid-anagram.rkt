#lang racket

(define (is-anagram s t)
  (equal? (sort (string->list s) char<?) (sort (string->list t) char<?)))