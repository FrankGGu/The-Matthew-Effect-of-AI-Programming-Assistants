(define (final-array-state nums k queries)
  (define n (length nums))
  (define arr (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! arr i (list-ref nums i)))

  (for ([q queries])
    (define i (list-ref q 0))
    (define v (list-ref q 1))
    (vector-set! arr i (* (list-ref (vector-ref arr i) 0) v)))

  (vector->list (vector-map (lambda (x) (list-ref x 0)) arr)))