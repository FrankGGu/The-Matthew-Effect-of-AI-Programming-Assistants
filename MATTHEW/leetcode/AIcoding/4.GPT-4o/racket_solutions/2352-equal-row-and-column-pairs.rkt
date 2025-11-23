(define (equalRowAndColumnPairs grid)
  (define n (length grid))
  (define row-count (make-hash))
  (define col-count (make-hash))

  (for ((i (in-range n)))
    (let ((row (vector->list (vector-ref grid i))))
      (hash-set! row-count row (add1 (hash-ref row-count row 0)))))

  (for ((j (in-range n)))
    (let ((col (for/list ((i (in-range n))) (vector-ref (vector-ref grid i) j))))
      (hash-set! col-count col (add1 (hash-ref col-count col 0)))))

  (for/sum ((row (in-hash-keys row-count)))
    (hash-ref row-count row 0) 
    * (hash-ref col-count row 0)))