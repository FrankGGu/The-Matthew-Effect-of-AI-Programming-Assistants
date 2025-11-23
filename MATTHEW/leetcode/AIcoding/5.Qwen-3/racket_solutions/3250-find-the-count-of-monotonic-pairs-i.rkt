#lang racket

(define (count-monotonic-pairs nums)
  (define (helper i prev count)
    (if (= i (length nums))
        count
        (let ((current (list-ref nums i)))
          (if (<= prev current)
              (helper (+ i 1) current (+ count 1))
              (helper (+ i 1) current count)))))
  (if (null? nums)
      0
      (helper 1 (car nums) 0)))