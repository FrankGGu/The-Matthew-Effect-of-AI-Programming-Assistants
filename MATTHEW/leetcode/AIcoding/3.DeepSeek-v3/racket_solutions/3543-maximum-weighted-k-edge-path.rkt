#lang racket

(define (maxWeightedKEdgePath n edges k src dst)
  (define dp (make-vector (add1 k) (make-vector n -inf.0)))
  (vector-set! (vector-ref dp 0) src 0.0)

  (for ([i (in-range 1 (add1 k))])
    (for ([edge edges])
      (define u (first edge))
      (define v (second edge))
      (define w (third edge))
      (when (>= (vector-ref (vector-ref dp (sub1 i)) u) -inf.0)
        (when (> (+ (vector-ref (vector-ref dp (sub1 i)) u) w)
                 (vector-ref (vector-ref dp i) v))
          (vector-set! (vector-ref dp i) v
                       (max (vector-ref (vector-ref dp i) v)
                            (+ (vector-ref (vector-ref dp (sub1 i)) u) w))))))

  (define result (vector-ref (vector-ref dp k) dst))
  (if (>= result -inf.0) result -1))