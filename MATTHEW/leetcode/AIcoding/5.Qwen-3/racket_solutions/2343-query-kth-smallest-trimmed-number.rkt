#lang racket

(define (kth-smallest-collisions nums k)
  (define (get-trimmed num index)
    (substring num 0 (- (string-length num) index)))

  (define (compare a b)
    (let ([a-val (string->number a)]
          [b-val (string->number b)])
      (if (= a-val b-val)
          0
          (if (< a-val b-val) -1 1))))

  (define sorted (sort nums compare))
  (list-ref sorted (sub1 k)))