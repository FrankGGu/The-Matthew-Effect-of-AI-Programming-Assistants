(define (relative-ranks nums)
  (define n (length nums))
  (define indexed-nums (map list (range n) nums))
  (define sorted-indexed-nums (sort indexed-nums > #:key second))
  (define result (make-vector n ""))

  (define (assign-rank i rank)
    (vector-set! result (first (list-ref sorted-indexed-nums i)) rank))

  (cond
    ((>= n 1) (assign-rank 0 "Gold Medal"))
    (else #f))
  (cond
    ((>= n 2) (assign-rank 1 "Silver Medal"))
    (else #f))
  (cond
    ((>= n 3) (assign-rank 2 "Bronze Medal"))
    (else #f))

  (for ([i (in-range 3 n)])
    (assign-rank i (number->string (+ i 1))))

  (vector->list result))