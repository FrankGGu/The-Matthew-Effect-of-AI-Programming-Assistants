#lang racket

(define (relative-sort-array arr1 arr2)
  (define (count-map lst)
    (for/fold ([m (hash)]) ([x lst])
      (hash-update m x add1 0)))
  (define cnt (count-map arr2))
  (define (cmp a b)
    (let ([ca (hash-ref cnt a 0)]
          [cb (hash-ref cnt b 0)])
      (if (= ca cb)
          (- (index-of arr2 a) (index-of arr2 b))
          (- cb ca))))
  (sort arr1 cmp))