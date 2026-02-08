(define (move-zeroes! nums)
  (let loop ([i 0] [j 0])
    (cond
      [(>= i (vector-length nums))
       (void)]
      [(not (= (vector-ref nums i) 0))
       (when (not (= i j))
         (vector-swap! nums i j))
       (loop (+ i 1) (+ j 1))]
      [else
       (loop (+ i 1) j)])))