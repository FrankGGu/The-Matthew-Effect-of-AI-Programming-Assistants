#lang racket

(define (count-beautiful-numbers low high k)
  (define (count n)
    (define (digit-diff x)
      (let loop ([x x] [first-digit 0] [last-digit 0] [len 0])
        (if (zero? x)
            (if (> len 1)
                (abs (- first-digit last-digit))
                0)
            (if (zero? len)
                (loop (quotient x 10) (remainder x 10) (remainder x 10) 1)
                (loop (quotient x 10) first-digit (remainder x 10) (add1 len))))))
    (let loop ([i 1] [cnt 0])
      (if (> i n)
          cnt
          (loop (add1 i) (if (zero? (remainder (digit-diff i) k)) (add1 cnt) cnt)))))
  (- (count high) (count (sub1 low))))