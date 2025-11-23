#lang racket

(define (count-partitions nums)
  (define n (length nums))
  (define sum-total (apply + nums))
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)
  (for ([num nums])
    (for ([i (in-range n -1 -1)])
      (when (>= (- sum-total (* 2 num)) (* 2 (vector-ref dp i)))
        (vector-set! dp (+ i 1) (+ (vector-ref dp (+ i 1)) (vector-ref dp i))))))
  (vector-ref dp (quotient n 2)))