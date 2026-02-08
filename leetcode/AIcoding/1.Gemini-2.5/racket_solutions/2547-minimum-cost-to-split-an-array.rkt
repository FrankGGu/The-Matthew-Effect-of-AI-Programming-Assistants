(define (min-cost-to-split nums k)
  (define n (vector-length nums))
  (define dp (make-vector (+ n 1) +inf.0))
  (vector-set! dp 0 0)

  (for ([i (in-range 1 (+ n 1))])
    (define current-trimmed-length 0)
    (define freq (make-hash))

    (for ([j (in-range (- i 1) -1 -1)])
      (define val (vector-ref nums j))
      (define old-count (hash-ref freq val 0))
      (define new-count (+ old-count 1))

      (hash-set! freq val new-count)

      (when (= old-count 1)
        (set! current-trimmed-length (+ current-trimmed-length 1)))

      (define cost-of-subarray (+ k current-trimmed-length))
      (define prev-dp-val (vector-ref dp j))
      (define current-dp-val (vector-ref dp i))

      (vector-set! dp i (min current-dp-val (+ prev-dp-val cost-of-subarray))))

  (vector-ref dp n))