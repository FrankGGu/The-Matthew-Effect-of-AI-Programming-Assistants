(define (subarrayRanges nums)
  (define n (length nums))
  (define total-sum 0)

  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (define subarray (sublist nums i (add1 j)))
      (define min (apply min subarray))
      (define max (apply max subarray))
      (set! total-sum (+ total-sum (- max min)))))

  total-sum)

(subarrayRanges '(1 2 3))