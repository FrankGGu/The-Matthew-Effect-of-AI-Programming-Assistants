(define (find-max-consecutive-ones nums)
  (let loop ([nums nums] [count 0] [max-count 0])
    (cond
      [(empty? nums) max-count]
      [(= (first nums) 1) (loop (rest nums) (+ count 1) (max max-count (+ count 1)))]
      [else (loop (rest nums) 0 max-count)])))