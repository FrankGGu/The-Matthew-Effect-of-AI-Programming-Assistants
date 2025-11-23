(define (range-sum-sorted-subarray-sums nums n left right)
  (define nums-vec (list->vector nums))

  (define all-sums '())
  (for ([i (in-range n)])
    (define current-subarray-sum 0)
    (for ([j (in-range i n)])
      (set! current-subarray-sum (+ current-subarray-sum (vector-ref nums-vec j)))
      (set! all-sums (cons current-subarray-sum all-sums))))

  (define sorted-sums (sort all-sums <))

  (define MOD 1000000007)
  (define result 0)

  (for ([k (in-range (- left 1) right)])
    (set! result (+ result (list-ref sorted-sums k)))
    (set! result (modulo result MOD)))

  result)