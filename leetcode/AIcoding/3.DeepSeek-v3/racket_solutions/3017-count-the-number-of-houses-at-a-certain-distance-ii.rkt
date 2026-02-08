#lang racket

(define (count-of-pairs n x y)
  (define dist (make-vector (+ n 1) 0))
  (define (min3 a b c) (min a (min b c)))
  (for* ([i (in-range 1 (+ n 1))]
         [j (in-range (+ i 1) (+ n 1))])
    (define d (min3 (abs (- j i))
                    (+ (abs (- x i)) 1 (abs (- j y)))
                    (+ (abs (- y i)) 1 (abs (- j x)))))
    (vector-set! dist d (add1 (vector-ref dist d))))
  (define result (make-vector (- n 1) 0))
  (for ([k (in-range 1 n)])
    (vector-set! result (- k 1) (* 2 (vector-ref dist k))))
  (vector->list result))