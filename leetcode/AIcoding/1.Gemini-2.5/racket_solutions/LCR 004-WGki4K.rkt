#lang racket

(define (single-number-ii nums)
  (let ([result 0])
    (for ([i (in-range 32)])
      (let ([sum-bits 0])
        (for ([n nums])
          (when (not (zero? (bitwise-and n (arithmetic-shift 1 i))))
            (set! sum-bits (+ sum-bits 1))))
        (when (= (modulo sum-bits 3) 1)
          (set! result (bitwise-ior result (arithmetic-shift 1 i))))))
    result))