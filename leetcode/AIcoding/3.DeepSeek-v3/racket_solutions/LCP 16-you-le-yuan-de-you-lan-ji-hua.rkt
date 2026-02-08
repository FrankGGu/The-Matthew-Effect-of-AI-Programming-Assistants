#lang racket

(define (max-happiness-value favorite time limit)
  (let* ([n (vector-length favorite)]
         [dp (make-vector (+ limit 1) -inf.0)])
    (vector-set! dp 0 0)
    (for ([i (in-range n)])
      (let ([h (vector-ref favorite i)]
            [t (vector-ref time i)])
        (for ([j (in-range limit (-1 -1) -1)])
          (when (>= j t)
            (vector-set! dp j (max (vector-ref dp j)
                                   (+ (vector-ref dp (- j t)) h))))))
    (apply max (vector->list dp))))