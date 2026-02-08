#lang racket

(define (trap height-list)
  (define height (list->vector height-list))
  (define n (vector-length height))
  (if (< n 3)
      0
      (let loop ((left 0)
                 (right (- n 1))
                 (left-max 0)
                 (right-max 0)
                 (water 0))
        (if (>= left right)
            water
            (let ((h-left (vector-ref height left))
                  (h-right (vector-ref height right)))
              (if (<= h-left h-right)
                  (if (>= h-left left-max)
                      (loop (+ left 1) right h-left right-max water)
                      (loop (+ left 1) right left-max right-max (+ water (- left-max h-left))))
                  (if (>= h-right right-max)
                      (loop left (- right 1) left-max h-right water)
                      (loop left (- right 1) left-max right-max (+ water (- right-max h-right)))))))))