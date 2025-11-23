(define (largest-sum-after-k-negations nums k)
  (define sorted-nums (sort nums <))
  (for ((i (in-range (min k (length sorted-nums)))))
    (set! (list-ref sorted-nums i) (* -1 (list-ref sorted-nums i))))
  (apply + sorted-nums))

(largest-sum-after-k-negations '(4 2 3) 1)