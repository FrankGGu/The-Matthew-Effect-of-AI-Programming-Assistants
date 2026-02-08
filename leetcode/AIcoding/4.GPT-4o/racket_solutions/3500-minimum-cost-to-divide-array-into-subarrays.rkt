(define (min-cost nums k)
  (define n (length nums))
  (define dp (make-vector (add1 n) (make-vector (add1 k) +inf.0)))
  (vector-set! dp 0 0)

  (for ([i (in-range 1 (add1 n))])
    (for ([j (in-range 1 (add1 (min k i)))])
      (define subarray-sum (apply + (sublist nums (- i j) i)))
      (define cost (+ (vector-ref dp (- i j)) subarray-sum))
      (vector-set! dp i (min (vector-ref dp i) cost))))

  (vector-ref dp n))

(min-cost '(1 2 3 4 5) 2)