#lang racket

(define (min-m-distance points)
  (define (manhattan p1 p2)
    (+ (abs (- (car p1) (car p2))) (abs (- (cadr p1) (cadr p2)))))
  (define (helper i j min-dist)
    (if (>= i (length points))
        min-dist
        (if (>= j (length points))
            (helper (+ i 1) 0 min-dist)
            (let ((current-dist (manhattan (list-ref points i) (list-ref points j))))
              (if (< current-dist min-dist)
                  (helper i (+ j 1) current-dist)
                  (helper i (+ j 1) min-dist))))))
  (helper 0 1 +inf.0))