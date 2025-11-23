#lang racket

(define (count-total-number-of-colored-cells p)
  (if (= p 1)
      1
      (+ (* (- p 1) 4) 1)))