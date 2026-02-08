#lang racket

(define (change-data-type students)
  (map (lambda (student)
         (list (first student)
               (string->number (second student))
               (string->number (third student))))
  students)