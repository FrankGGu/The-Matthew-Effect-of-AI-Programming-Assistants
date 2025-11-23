#lang racket

(define (maximum-swap num)
  (define digits (string->list (number->string num)))
  (define n (length digits))
  (define last (make-hash))
  (for ([i (in-range n)]
        [d (in-list digits)])
    (hash-set! last d i))
  (for ([i (in-range n)]
        [d (in-list digits)])
    (for ([j (in-range i n)]
          #:when (and (char<? d (list-ref digits j))
                      (<= (hash-ref last (list-ref digits j)) j)))
      (define temp (list-ref digits i))
      (list-set! digits i (list-ref digits j))
      (list-set! digits j temp)
      (return (string->number (list->string digits)))))
  (string->number (list->string digits)))