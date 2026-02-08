#lang racket

(define (detect-capital-use word)
  (define (all-uppercase? s) (string-ci=? s (string-upcase s)))
  (define (all-lowercase? s) (string-ci=? s (string-downcase s)))
  (define (first-uppercase-rest-lowercase? s)
    (and (char? (string-ref s 0))
         (char-ci=? (string-ref s 0) (string-upcase (string-ref s 0)))
         (string-ci=? (substring s 1) (string-downcase (substring s 1)))))
  (or (all-uppercase? word)
      (all-lowercase? word)
      (first-uppercase-rest-lowercase? word)))

(detect-capital-use "USA") ; Example call