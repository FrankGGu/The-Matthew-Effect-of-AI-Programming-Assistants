#lang racket

(define (count-hills-and-valleys nums)
  (define (is-hill i)
    (and (> i 0) (< i (- (length nums) 1)) (> (list-ref nums i) (list-ref nums (- i 1))) (> (list-ref nums i) (list-ref nums (+ i 1)))))
  (define (is-valley i)
    (and (> i 0) (< i (- (length nums) 1)) (< (list-ref nums i) (list-ref nums (- i 1))) (< (list-ref nums i) (list-ref nums (+ i 1)))))
  (define (loop i count)
    (if (>= i (- (length nums) 1))
        count
        (loop (+ i 1) (+ count (if (or (is-hill i) (is-valley i)) 1 0)))))
  (loop 0 0))