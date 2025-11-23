#lang racket

(define (sum-digit-differences-of-all-pairs nums)
  (for/sum ([k (in-range 10)])
    (let ([counts (make-vector 10 0)])
      (for-each (lambda (num)
                  (let* ([power-of-10 (expt 10 k)]
                         [digit (remainder (quotient num power-of-10) 10)])
                    (vector-set! counts digit (+ (vector-ref counts digit) 1))))
                nums)

      (for/sum ([d1 (in-range 10)])
        (for/sum ([d2 (in-range (+ d1 1) 10)])
          (* (vector-ref counts d1)
             (vector-ref counts d2)
             (- d2 d1)))))))