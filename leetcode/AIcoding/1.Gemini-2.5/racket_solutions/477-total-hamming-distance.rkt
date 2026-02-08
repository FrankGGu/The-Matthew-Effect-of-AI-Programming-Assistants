#lang racket

(define (total-hamming-distance nums)
  (for/sum ([i (in-range 32)])
    (define-values (count0 count1)
      (for/fold ([c0 0] [c1 0])
                ([num nums])
        (if (zero? (bitwise-and num (arithmetic-shift 1 i)))
            (values (add1 c0) c1)
            (values c0 (add1 c1)))))
    (* count0 count1)))