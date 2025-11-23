#lang racket

(define (remove-duplicates nums)
  (define len (vector-length nums))
  (if (zero? len)
      0
      (let ([k 0])
        (for ([i (in-range len)])
          (when (or (= i 0) (not (= (vector-ref nums i) (vector-ref nums (- k 1)))))
            (vector-set! nums k (vector-ref nums i))
            (set! k (+ k 1))))
        k)))