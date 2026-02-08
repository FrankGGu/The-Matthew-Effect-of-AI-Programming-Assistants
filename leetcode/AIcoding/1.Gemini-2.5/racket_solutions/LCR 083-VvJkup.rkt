#lang racket

(define (permute nums)
  (if (empty? nums)
      '(())
      (append-map (lambda (x)
                    (map (lambda (p) (cons x p))
                         (permute (remove x nums))))
                  nums)))