#lang racket

(define (closest to target)
  (define (f x)
    (abs (- x target)))
  (apply min (map f to)))

(define (find-closest-to-target arr target)
  (define n (length arr))
  (define res (make-vector n 0))
  (vector-set! res 0 (car arr))
  (for ([i (in-range 1 n)])
    (vector-set! res i (bitwise-ior (vector-ref res (- i 1)) (list-ref arr i))))
  (closest (vector->list res) target))