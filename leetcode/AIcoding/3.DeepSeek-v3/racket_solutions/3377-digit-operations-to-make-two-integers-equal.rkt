#lang racket

(define (min-operations num1 num2)
  (define (count-ops n)
    (let loop ([n n] [ops 0])
      (cond
        [(zero? n) ops]
        [(even? n) (loop (/ n 2) (add1 ops))]
        [else (loop (sub1 n) (add1 ops))])))
  (abs (- (count-ops num1) (count-ops num2))))