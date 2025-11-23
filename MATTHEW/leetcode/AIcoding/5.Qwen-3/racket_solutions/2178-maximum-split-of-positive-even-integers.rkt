#lang racket

(define (split-even-number n)
  (if (= n 2)
      (list 2)
      (cons 2 (split-even-number (- n 2)))))