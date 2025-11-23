#lang racket

(define (findMinArrowShots points)
  (define (sort-compare a b)
    (if (< (second a) (second b)) -1
        (if (> (second a) (second b)) 1 0)))
  (define sorted-points (sort points sort-compare))
  (define (count-arrows points)
    (define (helper points count end)
      (if (null? points)
          count
          (let* ((current (car points))
                 (start (first current))
                 (end (second current)))
            (if (> start end)
                (helper (cdr points) count end)
                (helper (cdr points) (add1 count) (min end (second (car (cdr points)))))))))
    (helper points 0 -1))
  (if (null? points) 0 (count-arrows sorted-points)))

(define points '((10 16) (2 8) (1 6) (7 12)))
(findMinArrowShots points)