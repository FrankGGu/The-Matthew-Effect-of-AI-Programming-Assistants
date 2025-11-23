#lang racket

(define (longest-subsequence-with-decreasing-adjacent-difference arr)
  (let* ([n (length arr)]
         [arr-vec (list->vector arr)])
    (cond
      [(= n 0) 0]
      [else
       (let ([dp (make-vector n 1)])
         (for ([i (in-range n)])
           (for ([j (in-range i)])
             (when (>= (vector-ref arr-vec j) (vector-ref arr-vec i))
               (vector-set! dp i (max (vector-ref dp i) (+ 1 (vector-ref dp j)))))))
         (apply max (vector->list dp)))))))