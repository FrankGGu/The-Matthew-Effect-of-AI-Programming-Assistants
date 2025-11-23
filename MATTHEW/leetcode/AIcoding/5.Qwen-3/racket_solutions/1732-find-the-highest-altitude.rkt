#lang racket

(define (largest-altitude nums)
  (let loop ((current 0) (max 0) (nums nums))
    (if (null? nums)
        max
        (loop (+ current (car nums)) (max max (+ current (car nums))) (cdr nums)))))