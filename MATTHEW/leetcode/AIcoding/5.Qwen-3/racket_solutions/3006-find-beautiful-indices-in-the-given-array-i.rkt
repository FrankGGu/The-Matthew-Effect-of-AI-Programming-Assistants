#lang racket

(define/contract (beautiful-indices nums s)
  (-> (listof exact-integer?) string? (listof exact-integer?))
  (define n (length nums))
  (define m (string-length s))
  (define result '())
  (define (is-beautiful i)
    (and (>= i 0) (< i n) (equal? (number->string (list-ref nums i)) s)))
  (for ([i (in-range n)])
    (when (is-beautiful i)
      (set! result (cons i result))))
  (reverse result))