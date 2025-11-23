#lang racket

(define (max-amount a b c)
  (define (convert x y z)
    (cond [(= x y) z]
          [(= x z) y]
          [else x]))
  (define (day1 x y z)
    (let ([x1 (convert x y z)]
          [y1 (convert y x z)]
          [z1 (convert z x y)])
      (values x1 y1 z)))
  (define (day2 x y z)
    (let-values ([(x2 y2 z2) (day1 x y z)])
      (let-values ([(x3 y3 z3) (day1 x2 y2 z2)])
        (values x3 y3 z3))))
  (let-values ([(x y z) (day2 a b c)])
    (max x y z)))