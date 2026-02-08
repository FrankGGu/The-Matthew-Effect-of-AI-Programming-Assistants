#lang racket

(define (min-operations target)
  (let ((total-increments 0)
        (max-val 0))
    (for-each (lambda (num)
                (set! total-increments (+ total-increments (bitwise-popcount num)))
                (set! max-val (max max-val num)))
              target)

    (let ((num-doubles (if (> max-val 0)
                           (- (integer-length max-val) 1)
                           0)))
      (+ total-increments num-doubles))))