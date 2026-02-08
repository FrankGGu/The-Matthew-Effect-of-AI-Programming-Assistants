#lang racket

(define (power x n mod)
  (cond
    [(= n 0) 1]
    [(even? n) (modulo (sqr (power x (/ n 2) mod)) mod)]
    [else (modulo (* x (power x (- n 1) mod)) mod)]))

(define (mod-inverse x mod)
  (power x (- mod 2) mod))

(define (number-of-sequences sick)
  (define n (length sick))
  (define mod 1000000007)
  (define fact (make-vector (+ n 1) 1))
  (define inv-fact (make-vector (+ n 1) 1))

  (for ([i (in-range 1 (+ n 1))])
    (vector-set! fact i (modulo (* (vector-ref fact (- i 1)) i) mod))
    (vector-set! inv-fact i (mod-inverse (vector-ref fact i) mod)))

  (define (comb a b)
    (if (or (< a b) (< b 0))
        0
        (modulo (* (vector-ref fact a) 
                   (vector-ref inv-fact b) 
                   (vector-ref inv-fact (- a b))) mod)))

  (define sick-sorted (sort sick <))
  (define total 1)
  (for ([i (in-range 1 (length sick-sorted))])
    (define prev (list-ref sick-sorted (- i 1)))
    (define curr (list-ref sick-sorted i))
    (define gap (- curr prev 1))
    (when (> gap 0)
      (set! total (modulo (* total (power 2 (- gap 1) mod)) mod))
      (set! total (modulo (* total (comb (+ (- curr prev) (- i 1)) gap)) mod)))

  total)