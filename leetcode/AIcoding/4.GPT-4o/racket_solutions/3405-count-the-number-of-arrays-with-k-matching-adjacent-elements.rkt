(define (count-arrays n k)
  (define mod 1000000007)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 (+ i 1))])
      (if (>= j k)
          (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp (- i j))) mod))
          (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp (- i j))) mod)))))

  (vector-ref dp n))

(count-arrays n k)