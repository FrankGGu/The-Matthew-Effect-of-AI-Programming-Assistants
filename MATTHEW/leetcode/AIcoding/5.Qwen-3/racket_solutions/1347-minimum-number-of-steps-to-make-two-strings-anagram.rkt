#lang racket

(define (min-steps-to-make-anagram s t)
  (define (count-chars str)
    (for/fold ([counts (make-hash)])
              ([c (in-string str)])
      (hash-update counts c add1 0)))
  (define s-counts (count-chars s))
  (define t-counts (count-chars t))
  (define (get-diff count)
    (for/sum ([k (in-hash-keys s-counts)])
      (max 0 (- (hash-ref s-counts k 0) (hash-ref t-counts k 0)))))
  (get-diff s-counts))