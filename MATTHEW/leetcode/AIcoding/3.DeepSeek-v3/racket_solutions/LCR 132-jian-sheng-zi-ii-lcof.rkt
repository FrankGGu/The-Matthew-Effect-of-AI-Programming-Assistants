#lang racket

(define (cutting-bamboo n)
  (if (<= n 3)
      n
      (let loop ([a 1] [b 1] [i 4])
        (if (> i n)
            (* a 3)
            (loop b (modulo (+ a b) 1000000007) (add1 i))))))