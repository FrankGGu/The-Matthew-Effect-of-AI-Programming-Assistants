#lang racket

(define (max-subarray nums)
  (define (helper i current-max max-so-far)
    (if (= i (length nums))
        max-so-far
        (let ((current-max (max (list-ref nums i) (+ (list-ref nums i) current-max))))
          (helper (+ i 1) current-max (max max-so-far current-max)))))
  (helper 0 (car nums) (car nums)))