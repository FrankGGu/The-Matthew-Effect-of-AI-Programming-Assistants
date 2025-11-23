(define (fillGrid n)
  (define grid (make-vector n (make-vector n 0)))
  (for ([i (in-range n)])
    (for ([j (in-range n)])
      (vector-set! (vector-ref grid i) j 
                   (if (even? (+ i j)) 1 0))))
  (vector->list grid))

(define (fillGridWrapper n)
  (fillGrid n))