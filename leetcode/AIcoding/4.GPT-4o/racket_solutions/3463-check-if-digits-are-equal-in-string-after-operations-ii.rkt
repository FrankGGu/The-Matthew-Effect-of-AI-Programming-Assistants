#lang racket

(define (are-digits-equal s)
  (define (char->digit c)
    (- (char->integer c) (char->integer #\0)))
  (define first-digit (char->digit (string-ref s 0)))
  (for/fold ([equal #t]) ([i (in-range (string-length s))])
    (if (= (char->digit (string-ref s i)) first-digit)
        equal
        #f)))

(define (checkDigitsEqualAfterOperations s)
  (are-digits-equal s))