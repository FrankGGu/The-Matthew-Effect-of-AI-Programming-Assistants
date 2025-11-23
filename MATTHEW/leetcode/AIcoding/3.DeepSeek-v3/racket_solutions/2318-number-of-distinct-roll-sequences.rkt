#lang racket

(define (distinct-sequences n)
  (define mod 1000000007)
  (define (gcd a b)
    (if (= b 0) a (gcd b (modulo a b))))

  (define dp (make-vector (max 4 n) 0))
  (vector-set! dp 0 0)
  (vector-set! dp 1 6)
  (vector-set! dp 2 (* 6 6))
  (vector-set! dp 3 (- (* 6 6 6) 6))

  (for ([i (in-range 4 (add1 n))])
    (vector-set! dp i 0)
    (for ([prev1 (in-range 1 7)])
      (for ([prev2 (in-range 1 7)])
        (when (and (not (= prev1 prev2)) (> (gcd prev1 prev2) 1))
          (for ([curr (in-range 1 7)])
            (when (and (not (= curr prev1)) (not (= curr prev2)) (> (gcd curr prev2) 1))
              (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp (- i 1))) mod))))))))

  (vector-ref dp n))