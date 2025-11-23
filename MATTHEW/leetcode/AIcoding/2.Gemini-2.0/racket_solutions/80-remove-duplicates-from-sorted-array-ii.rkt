(define (remove-duplicates nums)
  (let loop ([i 2] [k 2])
    (cond
      [(>= i (vector-length nums)) k]
      [(= (vector-ref nums i) (vector-ref nums (- k 2)))
       (loop (+ i 1) k)]
      [else
       (vector-set! nums k (vector-ref nums i))
       (loop (+ i 1) (+ k 1))])))