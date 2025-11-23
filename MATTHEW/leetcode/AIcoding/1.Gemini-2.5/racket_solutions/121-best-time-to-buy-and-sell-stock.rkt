#lang racket

(define (max-profit prices)
  (if (empty? prices)
      0
      (let-values (((_ final-max-profit)
                    (for/fold ([min-price (first prices)]
                               [max-profit 0])
                              ([price (rest prices)])
                      (values (min min-price price)
                              (max max-profit (- price min-price))))))
        final-max-profit)))