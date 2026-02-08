(define (array-rank-transform arr)
  (let* ([sorted-arr (sort (remove-duplicates arr) <)]
         [rank-map (make-hash)]
         [result (make-vector (length arr))])
    (for/fold ([rank 1])
              ([num (in-list sorted-arr)])
      (hash-set! rank-map num rank)
      (add1 rank))
    (for/vector ([i (in-range (length arr))])
      (vector-set! result i (hash-ref rank-map (vector-ref arr i))))
    result))