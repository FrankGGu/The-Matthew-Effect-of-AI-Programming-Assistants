#lang racket

(define (count-ideal-arrays n maxValue)
  (define mod 1000000007)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)
  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 (add1 maxValue))])
      (for ([k (in-range 1 (add1 (min i j)))])
        (vector-set! dp i
          (mod (+ (vector-ref dp i) (vector-ref dp (- i k))) mod)))))
  (define result 0)
  (for ([i (in-range 1 (+ n 1))])
    (set! result (mod (+ result (vector-ref dp i)) mod)))
  result)

(define (ideal-array n maxValue)
  (count-ideal-arrays n maxValue))