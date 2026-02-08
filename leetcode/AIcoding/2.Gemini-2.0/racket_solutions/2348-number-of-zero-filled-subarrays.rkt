(define (number-of-zero-filled-subarrays nums)
  (let loop ([nums nums] [count 0] [current-length 0])
    (cond
      [(empty? nums)
       (+ count (/ (* current-length (+ current-length 1)) 2))]
      [(= (first nums) 0)
       (loop (rest nums) count (+ current-length 1))]
      [else
       (loop (rest nums) (+ count (/ (* current-length (+ current-length 1)) 2)) 0)])))