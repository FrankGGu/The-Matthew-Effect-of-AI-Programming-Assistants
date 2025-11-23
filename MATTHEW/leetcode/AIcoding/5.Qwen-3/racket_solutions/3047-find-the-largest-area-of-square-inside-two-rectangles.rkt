#lang racket

(define (largest-square-area x1 y1 x2 y2 x3 y3 x4 y4)
  (define (overlap a1 a2 b1 b2)
    (if (> a1 b1) (max 0 (- (min a2 b2) (max a1 b1))) (max 0 (- (min a2 b2) (max a1 b1)))))

  (define ox (overlap x1 x2 x3 x4))
  (define oy (overlap y1 y2 y3 y4))

  (min ox oy))