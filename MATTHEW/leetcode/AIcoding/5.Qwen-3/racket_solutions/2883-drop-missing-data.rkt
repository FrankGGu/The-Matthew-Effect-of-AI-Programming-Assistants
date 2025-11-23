#lang racket

(define (drop-missing-data students)
  (filter (lambda (s) (and (not (equal? (list-ref s 1) #f)) (not (equal? (list-ref s 2) #f)))) students))