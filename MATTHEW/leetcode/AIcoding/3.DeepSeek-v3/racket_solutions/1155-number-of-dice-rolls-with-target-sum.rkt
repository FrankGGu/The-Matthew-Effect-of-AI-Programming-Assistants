(define/contract (num-rolls-to-target n k target)
  (-> exact-integer? exact-integer? exact-integer? exact-integer?)
  (define dp (make-vector (add1 n) (make-vector (add1 target) 0)))
  (vector-set! (vector-ref dp 0) 0 1)
  (for* ([i (in-range 1 (add1 n))]
         [j (in-range 1 (add1 target))]
         [face (in-range 1 (add1 k))])
    (when (>= j face)
      (vector-set! (vector-ref dp i) j 
                   (modulo (+ (vector-ref (vector-ref dp i) j)
                              (vector-ref (vector-ref dp (sub1 i)) (- j face)))
                             1000000007))))
  (vector-ref (vector-ref dp n) target))