#lang racket

(define-struct (Calculator) (value)
  #:methods
  [(define (add self n)
     (Calculator (+ (Calculator-value self) n)))

   (define (subtract self n)
     (Calculator (- (Calculator-value self) n)))

   (define (multiply self n)
     (Calculator (* (Calculator-value self) n)))

   (define (divide self n)
     (Calculator (/ (Calculator-value self) n)))

   (define (get self)
     (Calculator-value self))])

(define (new-Calculator initial-value)
  (Calculator initial-value))