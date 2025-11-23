#lang racket

(define (minimum-strings source target)
  (let loop ([i 0] [j 0] [count 0])
    (cond
      [(= j (string-length target)) count]
      [(= i (string-length source)) -1]
      [(char=? (string-ref source i) (string-ref target j))
       (loop (add1 i) (add1 j) (if (zero? j) (add1 count) count))]
      [else (loop (add1 i) j count)])))