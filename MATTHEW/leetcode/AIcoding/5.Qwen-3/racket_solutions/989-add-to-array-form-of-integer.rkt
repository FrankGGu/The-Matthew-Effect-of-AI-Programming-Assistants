#lang racket

(define (add-to-array-form num k)
  (define (add num k)
    (if (null? num)
        (if (= k 0) '() (cons (modulo k 10) (add '() (quotient k 10))))
        (let ((sum (+ (car num) (modulo k 10))))
          (cons (modulo sum 10)
                (add (cdr num) (quotient (+ sum (quotient k 10)) 10))))))
  (reverse (add num k)))