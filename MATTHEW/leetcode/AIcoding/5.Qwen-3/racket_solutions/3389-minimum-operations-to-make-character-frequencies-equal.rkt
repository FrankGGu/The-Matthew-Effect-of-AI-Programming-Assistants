#lang racket

(define (min-operations s)
  (define freq (make-hash))
  (for ([c s])
    (hash-set! freq c (+ 1 (hash-ref freq c 0))))
  (define counts (reverse (sort (hash-values freq) >)))
  (define n (string-length s))
  (define total 0)
  (for ([i (in-range (sub1 (length counts)))])
    (set! total (+ total (* (- (list-ref counts i) (list-ref counts (add1 i))) (add1 i)))))
  total)