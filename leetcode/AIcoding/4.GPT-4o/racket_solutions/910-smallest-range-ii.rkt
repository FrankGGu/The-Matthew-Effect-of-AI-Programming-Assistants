(define (smallest-range-ii A K)
  (let* ((min-val (apply min A))
         (max-val (apply max A)))
    (if (= min-val max-val)
        0
        (min (- max-val K) (- min-val K) (- max-val (+ K)) (- min-val (+ K))))))

(define (smallestRangeII A K)
  (smallest-range-ii A K))