(define (maxValue n index maxSum)
  (define (calc-sum k)
    (if (<= k 0) 0
        (+ (* k (+ k 1)) (* (- n k) maxSum))))

  (define (binary-search low high)
    (if (>= low high)
        low
        (let ((mid (quotient (+ low high) 2)))
          (if (<= (calc-sum mid) maxSum)
              (binary-search (+ mid 1) high)
              (binary-search low mid)))))

  (binary-search 1 (+ maxSum n))
)

(maxValue 4 2 6)