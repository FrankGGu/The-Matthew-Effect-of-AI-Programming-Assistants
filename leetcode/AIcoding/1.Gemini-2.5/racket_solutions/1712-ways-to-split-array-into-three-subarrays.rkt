#lang racket

(define (ways-to-split nums)
  (define n (vector-length nums))
  (define MOD 1000000007)

  (define P (make-vector n))
  (vector-set! P 0 (vector-ref nums 0))
  (for ([k (in-range 1 n)])
    (vector-set! P k (+ (vector-ref P (- k 1)) (vector-ref nums k))))

  (define total-sum (vector-ref P (- n 1)))
  (define ans 0)
  (define k1 1)
  (define k2 1)

  (for ([i (in-range 0 (- n 2))])
    (define s1 (vector-ref P i))

    (set! k1 (max k1 (+ i 1)))
    (while (and (< k1 (- n 1))
                (< (vector-ref P k1) (* 2 s1)))
      (set! k1 (+ k1 1)))

    (set! k2 (max k2 (+ i 1)))
    (while (and (< k2 (- n 1))
                (<= (vector-ref P k2) (quotient (+ total-sum s1) 2)))
      (set! k2 (+ k2 1)))

    (when (< k1 k2)
      (set! ans (modulo (+ ans (- k2 k1)) MOD))))

  ans)