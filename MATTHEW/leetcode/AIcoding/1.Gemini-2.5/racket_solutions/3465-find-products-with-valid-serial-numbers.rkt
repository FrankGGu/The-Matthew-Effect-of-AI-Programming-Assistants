#lang racket

(define (valid-serial-number? sn)
  (and (string? sn)
       (not (string-empty? sn))
       (string-prefix? sn "SN")))

(define (find-products-with-valid-serial-numbers products)
  (filter (lambda (product)
            (let ((sn (second product)))
              (valid-serial-number? sn)))
          products))