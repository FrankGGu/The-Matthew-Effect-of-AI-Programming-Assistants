#lang racket

(define (max-min-sums arr k)
  (define n (length arr))
  (define dp (make-vector n 0))
  (define (min-subarray-sum i)
    (let loop ((j (max 0 (- i 1))) (sum 0) (min-sum +inf.0))
      (if (> j (- i k)) min-sum
          (begin
            (set! sum (+ sum (vector-ref arr j)))
            (if (<= j (- i 1))
                (loop (- j 1) sum (min min-sum sum))
                (loop (- j 1) sum min-sum))))))
  (define (max-subarray-sum i)
    (let loop ((j (max 0 (- i 1))) (sum 0) (max-sum -inf.0))
      (if (> j (- i k)) max-sum
          (begin
            (set! sum (+ sum (vector-ref arr j)))
            (if (<= j (- i 1))
                (loop (- j 1) sum (max max-sum sum))
                (loop (- j 1) sum max-sum))))))
  (for ([i (in-range n)])
    (vector-set! dp i (+ (max-subarray-sum i) (min-subarray-sum i))))
  (vector-ref dp (- n 1)))