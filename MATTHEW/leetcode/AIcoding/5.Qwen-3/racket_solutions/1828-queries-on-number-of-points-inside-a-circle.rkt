#lang racket

(define (num-points-in-circle points circles)
  (define (distance-squared x1 y1 x2 y2)
    (+ (expt (- x1 x2) 2) (expt (- y1 y2) 2)))

  (define (in-circle? x y cx cy r)
    (<= (distance-squared x y cx cy) (* r r)))

  (for/list ([circle circles])
    (define cx (car circle))
    (define cy (cadr circle))
    (define r (caddr circle))
    (count (lambda (point)
             (in-circle? (car point) (cadr point) cx cy r))
           points)))

(define (main)
  (define input (read))
  (define points (list-ref input 0))
  (define circles (list-ref input 1))
  (displayln (num-points-in-circle points circles)))

(main)