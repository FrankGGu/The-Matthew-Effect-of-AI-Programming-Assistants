#lang racket

(define (select-data data)
  (filter (lambda (x) (and (>= (second x) 10) (<= (second x) 20))) data))

(define (main)
  (define input '((1 5) (2 15) (3 25) (4 10) (5 20)))
  (select-data input))

(main)