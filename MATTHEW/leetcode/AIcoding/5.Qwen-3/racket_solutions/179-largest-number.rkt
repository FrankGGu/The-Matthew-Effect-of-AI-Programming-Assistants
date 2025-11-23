#lang racket

(define (largest-number nums)
  (define (compare a b)
    (if (> (string->number (string-append a b)) (string->number (string-append b a)))
        -1
        1))
  (define sorted (sort (map number->string nums) compare))
  (if (and (not (null? sorted)) (equal? (car sorted) "0"))
      "0"
      (string-join sorted "")))