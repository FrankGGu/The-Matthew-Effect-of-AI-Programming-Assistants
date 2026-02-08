#lang racket

(define-struct robot (width height x y dir))

(define (robot-init width height)
  (make-robot width height 0 0 "East"))

(define (robot-step robot)
  (let ([width (robot-width robot)]
        [height (robot-height robot)]
        [x (robot-x robot)]
        [y (robot-y robot)]
        [dir (robot-dir robot)])
    (case dir
      [("East")
       (if (< x (sub1 width))
           (make-robot width height (add1 x) y dir)
           (make-robot width height x y "North"))]
      [("North")
       (if (< y (sub1 height))
           (make-robot width height x (add1 y) dir)
           (make-robot width height x y "West"))]
      [("West")
       (if (> x 0)
           (make-robot width height (sub1 x) y dir)
           (make-robot width height x y "South"))]
      [("South")
       (if (> y 0)
           (make-robot width height x (sub1 y) dir)
           (make-robot width height x y "East"))])))

(define (robot-get-pos robot)
  (list (robot-x robot) (robot-y robot)))

(define (robot-get-dir robot)
  (robot-dir robot))

(define (robot-move steps robot)
  (if (zero? steps)
      robot
      (robot-move (sub1 steps) (robot-step robot))))