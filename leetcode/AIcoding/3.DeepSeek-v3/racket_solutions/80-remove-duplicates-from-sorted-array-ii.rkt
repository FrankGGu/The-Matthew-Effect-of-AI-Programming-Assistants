(define/contract (remove-duplicates nums)
  (-> (listof exact-integer?) exact-integer?)
  (if (null? nums)
      0
      (let loop ([i 0] [j 1] [count 1] [nums nums])
        (cond
          [(>= j (length nums)) i]
          [(= (list-ref nums j) (list-ref nums (sub1 j)))
           (if (< count 2)
               (loop (add1 i) (add1 j) (add1 count) (list-set nums (add1 i) (list-ref nums j)))
               (loop i (add1 j) count nums))]
          [else
           (loop (add1 i) (add1 j) 1 (list-set nums (add1 i) (list-ref nums j)))]))))