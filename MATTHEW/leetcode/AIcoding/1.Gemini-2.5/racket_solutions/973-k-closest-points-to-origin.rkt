#lang racket

(define (k-closest-points points k)
  (define (distance-squared p)
    (let* ((x (car p))
           (y (cadr p)))
      (+ (* x x) (* y y))))

  (define (point-with-distance p)
    (list (distance-squared p) p))

  (define sorted-points-with-distances
    (sort (map point-with-distance points)
          (lambda (p1 p2)
            (< (car p1) (car p2)))))

  (map cadr (take sorted-points-with-distances k)))