(define/contract (num-identical-pairs nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([count 0]
             [i 0]
             [j 1])
    (cond
      [(>= i (length nums)) count]
      [(>= j (length nums)) (loop count (add1 i) (+ i 2))]
      [(= (list-ref nums i) (list-ref nums j)) (loop (add1 count) i (add1 j))]
      [else (loop count i (add1 j))])))