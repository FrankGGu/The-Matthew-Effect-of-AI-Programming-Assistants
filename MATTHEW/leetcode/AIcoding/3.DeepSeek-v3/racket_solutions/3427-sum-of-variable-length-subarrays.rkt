(define/contract (sum-subarrays nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [sum 0])
    (if (>= i (length nums))
        sum
        (let inner-loop ([j i] [current-sum 0] [total sum])
            (if (> j (length nums))
                (loop (add1 i) total)
                (inner-loop (add1 j) (+ current-sum (list-ref nums j)) (+ total current-sum))))))