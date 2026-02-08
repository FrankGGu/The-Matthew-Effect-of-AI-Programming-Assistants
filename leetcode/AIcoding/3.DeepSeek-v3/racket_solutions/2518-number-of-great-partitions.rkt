#lang racket

(define (count-partitions nums k)
  (let* ([total (foldl + 0 nums)]
         [n (length nums)]
         [modulo-const 1000000007])
    (if (< total (* 2 k))
        0
        (let ([dp (make-vector (+ k 1) 0)])
          (vector-set! dp 0 1)
          (for ([num nums])
            (for ([i (in-range k (-1 -1) -1)])
              (when (>= i num)
                (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp (- i num))) modulo-const))))
          (let ([total-subsets (expt 2 n)])
            (let ([invalid-subsets 0])
              (for ([i (in-range 0 k)])
                (set! invalid-subsets (modulo (+ invalid-subsets (vector-ref dp i)) modulo-const)))
              (modulo (- total-subsets (* 2 invalid-subsets)) modulo-const))))))