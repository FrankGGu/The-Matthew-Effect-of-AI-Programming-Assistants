#lang racket

(require srfi/13)

(define (apply-discount-to-prices sentence discount)
  (define (is-price? word)
    (and (string-starts-with? word "$")
         (> (string-length word) 1)
         (let ([num-str (substring word 1 (string-length word))])
           (and (regexp-match? #rx"^[0-9]+$" num-str)
                (string->number num-str)))))

  (define (process-word word)
    (let ([price-val (is-price? word)])
      (if price-val
          (let* ([original-price (exact->inexact price-val)]
                 [discount-factor (/ (- 100 discount) 100.0)]
                 [discounted-price (* original-price discount-factor)])
            (string-append "$" (format "~,2f" discounted-price)))
          word)))

  (string-join (map process-word (string-split sentence " ")) " "))