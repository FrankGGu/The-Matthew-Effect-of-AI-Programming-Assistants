#lang racket

(define (judge-circle moves)
  (let loop ([moves moves] [x 0] [y 0])
    (cond
      [(null? moves) (= x 0) (= y 0)]
      [(char=? #\U (car moves)) (loop (cdr moves) x (+ y 1))]
      [(char=? #\D (car moves)) (loop (cdr moves) x (- y 1))]
      [(char=? #\L (car moves)) (loop (cdr moves) (- x 1) y)]
      [(char=? #\R (car moves)) (loop (cdr moves) (+ x 1) y)])))