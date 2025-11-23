#lang racket

(define (count-balanced-permutations n)
  (if (< n 0)
      0
      (let* ([dp (make-vector (+ n 1) 0)])
        (vector-set! dp 0 1)
        (for ([i (in-range 1 (+ n 1))])
          (for ([j (in-range 0 i)])
            (vector-set! dp i
                         (+ (vector-ref dp i)
                            (* (vector-ref dp j)
                               (vector-ref dp (- i 1 j)))))))
        (vector-ref dp n))))