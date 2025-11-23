#lang racket

(define (beautiful-indices nums s)
  (define (is-beautiful i)
    (and (>= i 0)
         (<= i (- (vector-length nums) 1))
         (>= (vector-ref nums i) s)))
  (define (check i)
    (and (is-beautiful i)
         (or (not (>= (+ i 1) (vector-length nums)))
             (not (is-beautiful (+ i 1))))))
  (define (loop i res)
    (if (>= i (vector-length nums))
        res
        (loop (+ i 1) (if (check i) (cons i res) res))))
  (reverse (loop 0 '())))