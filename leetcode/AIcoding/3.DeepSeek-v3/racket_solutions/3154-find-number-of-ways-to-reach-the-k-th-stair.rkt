#lang racket

(define (ways-to-reach-stairs k)
  (let loop ([n 0] [a 1] [b 1] [c 2] [i 2])
    (cond
      [(> i k) a]
      [(= i k) c]
      [else (loop n b c (+ a b c) (+ i 1))])))