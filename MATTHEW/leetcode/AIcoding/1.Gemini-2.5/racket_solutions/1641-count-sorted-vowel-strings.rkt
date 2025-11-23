#lang racket

(define (count-vowel-strings n)
  (/ (* (+ n 4) (+ n 3) (+ n 2) (+ n 1))
     24))