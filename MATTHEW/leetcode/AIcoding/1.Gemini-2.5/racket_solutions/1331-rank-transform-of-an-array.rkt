#lang racket

(require racket/list)
(require racket/hash)
(require racket/sequence)

(define (array-rank-transform arr)
  (define unique-sorted-arr (sort (remove-duplicates arr) <))
  (define rank-map (make-hash))

  (for ([val unique-sorted-arr] [i (in-naturals 1)])
    (hash-set! rank-map val i))

  (map (lambda (x) (hash-ref rank-map x)) arr))