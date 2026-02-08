#lang racket

(define (concatenated-divisibility nums k)
  (define n (length nums))
  (define count 0)
  (for ([i (in-range n)])
    (for ([j (in-range n)])
      (when (not (equal? i j))
        (define num (string->number (string-append (number->string (list-ref nums i))
                                                   (number->string (list-ref nums j)))))
        (when (and num (zero? (modulo num k)))
          (set! count (add1 count))))))
  count)