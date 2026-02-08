(define (numDistinctRolls n k target)
  (define mod 1000000007)
  (define dp (make-vector (+ 1 n) (make-vector (+ 1 target) 0)))
  (vector-set! dp 0 1)

  (for ([i (in-range 1 (+ 1 n))])
    (for ([j (in-range 1 (+ 1 target))])
      (for ([x (in-range 1 (+ 1 k))])
        (when (>= j x)
          (vector-set! dp i (mod (+ (vector-ref dp i) (vector-ref (vector-ref dp (- i 1)) (- j x))) mod) mod)))))

  (vector-ref dp n target))

(define (numDistinctRolls-main n k target)
  (numDistinctRolls n k target))