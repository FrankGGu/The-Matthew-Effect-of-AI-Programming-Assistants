(define (sum-of-subarray-lengths arr)
  (define n (length arr))
  (define total-sum 0)
  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (set! total-sum (+ total-sum (apply + (sublist arr i (+ j 1)))))))
  total-sum)

(sum-of-subarray-lengths '(1 2 3)) ; example usage