(define (adjacent-increasing-subarrays nums)
  (let loop ([i 0] [count 0])
    (cond
      [(>= i (sub1 (length nums))) count]
      [(< (list-ref nums i) (list-ref nums (add1 i)))
       (let loop2 ([j (add1 i)])
         (cond
           [(or (>= j (sub1 (length nums)))
                (>= (list-ref nums j) (list-ref nums (add1 j))))
            (loop (add1 j) (add1 count))]
           [else (loop2 (add1 j))]))]
      [else (loop (add1 i) count)])))