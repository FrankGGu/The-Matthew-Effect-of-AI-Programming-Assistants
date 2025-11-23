(define (smallestRangeI nums k)
  (define max-num (apply max nums))
  (define min-num (apply min nums))
  (max 0 (- max-num min-num (* 2 k))))