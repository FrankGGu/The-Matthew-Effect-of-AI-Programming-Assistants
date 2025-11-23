#lang racket

(define (min-time-to-visit-all-points n points)
  (define (distance p1 p2)
    (+ (abs (- (car p1) (car p2))) (abs (- (cadr p1) (cadr p2)))))
  (define (loop i total)
    (if (= i n) total
        (loop (+ i 1) (+ total (distance (list-ref points i) (list-ref points (- i 1)))))))
  (loop 1 0))