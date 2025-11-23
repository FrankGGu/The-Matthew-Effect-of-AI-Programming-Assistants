#lang racket

(define (read-binary-watch turnedOn)
  (define (popcount n)
    (let loop ((num n) (count 0))
      (if (zero? num)
          count
          (loop (arithmetic-shift num -1) (+ count (bitwise-and num 1))))))

  (for/list ((h (in-range 0 12))
             (m (in-range 0 60))
             #:when (= (+ (popcount h) (popcount m)) turnedOn))
    (format "~a:~2,'0d" h m)))