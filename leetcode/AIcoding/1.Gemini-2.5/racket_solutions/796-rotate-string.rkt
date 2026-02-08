#lang racket

(define (rotate-string s goal)
  (if (not (= (string-length s) (string-length goal)))
      #f
      (string-contains? (string-append s s) goal)))