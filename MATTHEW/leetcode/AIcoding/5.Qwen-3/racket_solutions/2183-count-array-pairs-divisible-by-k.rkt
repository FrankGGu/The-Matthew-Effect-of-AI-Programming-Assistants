#lang racket

(define (count-array-pairs-divisible-by-k nums k)
  (define mod-count (make-hash))
  (define result 0)
  (for ([num nums])
    (define mod (modulo num k))
    (define complement (- k mod))
    (when (hash-has-key? mod-count complement)
      (set! result (+ result (hash-ref mod-count complement))))
    (hash-update! mod-count mod add1 0))
  result)