#lang racket/base

(define (distance-between-bus-stops distance start destination)
  (let* ((s (min start destination))
         (d (max start destination)))
    (let ((dist-cw
           (for/sum ((i (in-range s d)))
             (list-ref distance i)))
          (total-dist
           (for/sum ((x distance)) x)))
      (min dist-cw (- total-dist dist-cw)))))