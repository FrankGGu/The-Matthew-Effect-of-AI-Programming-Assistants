#lang racket

(define (numberOfWays s)
  (define (count-ways s)
    (let loop ([i 0] [a 0] [b 0] [res 0])
      (if (>= i (string-length s))
          res
          (let ([c (string-ref s i)])
            (if (char=? c #\0)
                (loop (+ i 1) (+ a 1) b (+ res b))
                (loop (+ i 1) a (+ b 1) (+ res a))))))
  (count-ways s))