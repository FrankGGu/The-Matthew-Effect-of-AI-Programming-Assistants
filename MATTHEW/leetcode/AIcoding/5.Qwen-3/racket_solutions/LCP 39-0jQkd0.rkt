#lang racket

(define (min-falling-path-sum grid)
  (define n (length grid))
  (define dp (make-vector n (make-vector n 0)))
  (for ([i (in-range n)])
    (vector-set! dp 0 i (vector-ref (vector-ref grid 0) i)))
  (for ([i (in-range 1 n)])
    (for ([j (in-range n)])
      (vector-set! dp i j
                   (+ (vector-ref (vector-ref grid i) j)
                      (apply min (for/list ([k (in-range (max 0 (- j 1)) (min n (+ j 2)))]
                                           [v (in-vector (vector-ref dp (- i 1)))])
                           (vector-ref v k)))))))
  (apply min (vector->list (vector-ref dp (- n 1)))))