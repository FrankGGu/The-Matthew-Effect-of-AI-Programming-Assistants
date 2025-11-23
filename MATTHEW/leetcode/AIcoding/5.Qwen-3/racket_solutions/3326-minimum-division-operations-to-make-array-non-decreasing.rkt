#lang racket

(define (min-div-ops nums)
  (define (helper i prev)
    (if (>= i (length nums))
        0
        (let ((current (list-ref nums i)))
          (if (<= current prev)
              (helper (+ i 1) current)
              (+ 1 (helper (+ i 1) (floor (/ current 2))))))))
  (helper 0 0))