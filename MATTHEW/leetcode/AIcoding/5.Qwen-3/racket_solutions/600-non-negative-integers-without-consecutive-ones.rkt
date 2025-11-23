#lang racket

(define (non-negative-integers-without-consecutive-ones n)
  (define (count x)
    (let loop ([x x] [prev 0] [result 0])
      (if (= x 0)
          result
          (let* ([bit (bitwise-and x 1)]
                 [next-x (arithmetic-shift x -1)]
                 [new-result (if (= prev 1)
                                 result
                                 (+ result (expt 2 (bitwise-length x))))
                 [new-prev (if (= bit 1) 1 0)])
            (loop next-x new-prev new-result)))))
  (if (= n 0)
      1
      (- (count (add1 n)) 1)))