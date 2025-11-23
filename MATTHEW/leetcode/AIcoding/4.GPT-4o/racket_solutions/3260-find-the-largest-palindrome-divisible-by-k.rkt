#lang racket

(define (largest-palindrome k)
  (define (is-palindrome n)
    (let ((s (number->string n)))
      (equal? s (string-reverse s))))

  (define (largest-palindrome-below n)
    (for/fold ([result 0]) ([i (in-range n 0 -1)])
      (if (and (is-palindrome i) (zero? (modulo i k)))
          (max result i)
          result)))

  (define upper-bound (* 10 (expt 10 (- (quotient (log (exact->inexact k)) (log 10)) 1))))

  (largest-palindrome-below upper-bound))

(largest-palindrome k)