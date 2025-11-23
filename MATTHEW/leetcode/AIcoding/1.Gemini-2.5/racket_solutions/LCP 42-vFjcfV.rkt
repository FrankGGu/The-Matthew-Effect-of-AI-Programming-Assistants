#lang racket

(define (point-in-circle? px py cx cy r)
  (<= (+ (sqr (- px cx)) (sqr (- py cy))) (sqr r)))

(define (solve points circles)
  (count
   (lambda (point)
     (let ((px (car point))
           (py (cadr point)))
       (ormap
        (lambda (circle)
          (let ((cx (car circle))
                (cy (cadr circle))
                (r (caddr circle)))
            (point-in-circle? px py cx cy r)))
        circles)))
   points))