#lang racket

(define (get-amounts nums)
  (define n (length nums))
  (define left (make-vector n 1))
  (define right (make-vector n 1))
  (for ([i (in-range 1 n)])
    (vector-set! left i (* (vector-ref left (- i 1)) (vector-ref nums (- i 1)))))
  (for ([i (in-range (- n 2) -1 -1)])
    (vector-set! right i (* (vector-ref right (+ i 1)) (vector-ref nums (+ i 1)))))
  (for/list ([i (in-range n)])
    (* (vector-ref left i) (vector-ref right i))))