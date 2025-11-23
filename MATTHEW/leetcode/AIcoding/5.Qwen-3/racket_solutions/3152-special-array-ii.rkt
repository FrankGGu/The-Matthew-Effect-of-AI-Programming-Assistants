#lang racket

(define (special-array nums)
  (define (count-less-equal x)
    (length (filter (lambda (n) (<= n x)) nums)))
  (define (count-greater x)
    (length (filter (lambda (n) (> n x)) nums)))
  (let loop ([i 0])
    (if (> i (length nums))
        -1
        (if (= (count-less-equal i) (count-greater i))
            i
            (loop (+ i 1))))))