#lang racket

(define (maximum-distinct-elements-after-operations nums k)
  (define freq (make-hash))

  ;; Populate frequency map
  (for-each (lambda (num)
              (hash-update! freq num (lambda (v) (add1 (or v 0))) 0))
            nums)

  (define initial-distinct-count (hash-count freq))
  (define total-extra-conversions 0)

  ;; Calculate total number of "extra" copies that can be converted
  ;; An extra copy is any occurrence of a number beyond its first occurrence.
  (hash-for-each (lambda (num count)
                   (when (> count 1)
                     (set! total-extra-conversions (+ total-extra-conversions (- count 1)))))
                 freq)

  ;; The number of distinct elements we can add is limited by k and the available extra copies.
  (define conversions-possible (min k total-extra-conversions))

  ;; The final maximum number of distinct elements is the initial count
  ;; plus the number of conversions we can perform.
  (+ initial-distinct-count conversions-possible))