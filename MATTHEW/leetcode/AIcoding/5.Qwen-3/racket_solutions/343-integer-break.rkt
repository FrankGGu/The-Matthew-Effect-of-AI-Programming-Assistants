#lang racket

(define (integer-break n)
  (if (<= n 3)
      (- n 1)
      (let loop ([n n] [res 1])
        (if (< n 4)
            (* res n)
            (loop (- n 3) (* res 3))))))