#lang racket

(define (can-win stones)
  (let loop ([i 0] [xor-sum 0])
    (if (>= i (vector-length stones))
        (not (zero? xor-sum))
        (loop (add1 i) (bitwise-xor xor-sum (vector-ref stones i))))))