(define (max-sum-after-partitioning arr k)
  (define n (vector-length arr))
  (define dp (make-vector (+ n 1) 0))

  (for ([i (in-range 1 (+ n 1))])
    (define current-max-val 0)
    (define max-sum-at-i 0)

    (for ([j (in-range 1 (min i (+ k 1)))])
      (define current-element-index (- i j))

      (set! current-max-val (max current-max-val (vector-ref arr current-element-index)))

      (define sum-for-this-partition (* current-max-val j))
      (define total-sum (+ (vector-ref dp (- i j)) sum-for-this-partition))

      (set! max-sum-at-i (max max-sum-at-i total-sum)))

    (vector-set! dp i max-sum-at-i))

  (vector-ref dp n))