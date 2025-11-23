(define/contract (max-subarrays nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [and-sum (foldl bitwise-and (first nums) (rest nums))] [res 0] [current-and (first nums)])
    (if (empty? nums)
        res
        (let ([new-and (bitwise-and current-and (first nums))])
          (if (= new-and and-sum)
              (loop (rest nums) and-sum (add1 res) (first nums))
              (loop (rest nums) and-sum res new-and))))))