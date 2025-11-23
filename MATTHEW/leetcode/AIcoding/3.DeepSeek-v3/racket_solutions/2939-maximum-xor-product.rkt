#lang racket

(define (maximum-xor-product a b n)
  (define mod (expt 10 9 7))
  (define (bit-set? x k)
    (bitwise-bit-set? x k))
  (define (set-bit x k)
    (bitwise-ior x (arithmetic-shift 1 k)))

  (define x 0)
  (define y 0)

  (for ([k (in-range (- n 1) -1 -1)])
    (define mask (arithmetic-shift 1 k))
    (define a-bit (bit-set? a k))
    (define b-bit (bit-set? b k))

    (cond
      [(and a-bit b-bit)
       (set! x (set-bit x k))
       (set! y (set-bit y k))]
      [(or a-bit b-bit)
       (if (> x y)
           (set! y (set-bit y k))
           (set! x (set-bit x k)))]
      [else
       (set! x (set-bit x k))
       (set! y (set-bit y k))]))

  (modulo (* x y) mod))