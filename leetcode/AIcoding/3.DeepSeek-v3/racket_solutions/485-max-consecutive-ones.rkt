(define/contract (find-max-consecutive-ones nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [current 0] [max-count 0])
    (cond
      [(empty? nums) (max current max-count)]
      [(= (first nums) 1) (loop (rest nums) (+ current 1) max-count)]
      [else (loop (rest nums) 0 (max current max-count))]))