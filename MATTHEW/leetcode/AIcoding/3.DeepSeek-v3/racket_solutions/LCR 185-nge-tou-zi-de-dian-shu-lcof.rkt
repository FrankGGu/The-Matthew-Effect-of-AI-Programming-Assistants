(define (dice-probability n m x)
  (define dp (make-vector (add1 n) (make-vector (add1 x) 0)))
  (vector-set! (vector-ref dp 0) 0 1)
  (for* ([i (in-range 1 (add1 n))]
         [j (in-range 1 (add1 x))]
         [k (in-range 1 (add1 (min j m)))])
    (vector-set! (vector-ref dp i) j 
                 (+ (vector-ref (vector-ref dp i) j)
                    (vector-ref (vector-ref dp (sub1 i)) (- j k)))))
  (let ([total (expt m n)]
        [favorable (vector-ref (vector-ref dp n) x)])
    (/ favorable total)))