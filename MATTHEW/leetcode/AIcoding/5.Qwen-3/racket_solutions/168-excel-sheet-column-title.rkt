#lang racket

(define (convert-to-title column-number)
  (define (helper n)
    (if (= n 0)
        ""
        (let* ([remainder (- (modulo n 26) 1)]
               [char (integer->char (+ remainder 65))])
          (string-append (helper (quotient (- n 1) 26)) (string char)))))
  (helper column-number))