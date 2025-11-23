(define (smallestRangeI nums k)
  (let* ([min (apply min nums)]
         [max (apply max nums)]
         [range (- max min)])
    (if (<= range (* 2 k))
        0
        (- range (* 2 k)))))

(define (smallestRangeI nums k)
  (smallestRangeI nums k))