#lang racket

(define (rand10)
  (let loop ()
    (let* ((row (- (rand7) 1))
           (col (- (rand7) 1))
           (val (+ (* row 7) col)))
      (if (<= val 39)
          (+ (remainder val 10) 1)
          (loop)))))