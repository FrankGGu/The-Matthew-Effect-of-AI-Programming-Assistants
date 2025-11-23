#lang racket

(define (drop-duplicate-rows df)
  (define (unique-row? row seen)
    (if (member row seen #:key cdr)
        #f
        (begin
          (set! seen (cons row seen))
          #t)))
  (define seen '())
  (filter (lambda (row) (unique-row? row seen)) df))