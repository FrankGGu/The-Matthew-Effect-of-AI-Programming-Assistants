#lang racket

(define (solve s t)
  (define (string->char-set str)
    (list->set (string->list str)))

  (define s-chars (string->char-set s))
  (define t-chars (string->char-set t))

  (define common-chars (set-intersect s-chars t-chars))

  (if (set-empty? common-chars)
      0
      1))