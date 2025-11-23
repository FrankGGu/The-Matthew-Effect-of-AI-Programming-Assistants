#lang racket

(define (equal-digits? s)
  (define (count-digits s)
    (for/fold ([counts (hash)]) ([c s])
      (hash-update counts c add1 0)))
  (define counts (count-digits s))
  (define values (hash-values counts))
  (andmap (lambda (x) (= x (car values))) values))