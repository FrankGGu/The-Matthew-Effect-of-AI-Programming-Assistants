(define (integer-break n)
  (define dp (make-vector (+ n 1) 0))

  (vector-set! dp 2 1)
  (vector-set! dp 3 2)

  (for ([i (in-range 4 (+ n 1))])
    (define max-prod-i 0)
    (for ([j (in-range 1 i)])
      (define current-prod
        (max (* j (- i j))
             (* j (vector-ref dp (- i j)))))
      (set! max-prod-i (max max-prod-i current-prod)))
    (vector-set! dp i max-prod-i))

  (vector-ref dp n))