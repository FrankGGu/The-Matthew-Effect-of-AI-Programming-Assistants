#lang racket

(define/contract (num-matching-subseqs s words)
  (-> string? (listof string?) exact-nonnegative-integer?)
  (let ([count (make-hash)])
    (for ([c (in-string s)])
      (hash-update! count c add1 0))
    (for/sum ([word words])
      (let ([w-count (make-hash)])
        (for ([c (in-string word)])
          (hash-update! w-count c add1 0))
        (for/sum ([k (in-hash-keys count)])
          (min (hash-ref w-count k 0) (hash-ref count k 0)))))))