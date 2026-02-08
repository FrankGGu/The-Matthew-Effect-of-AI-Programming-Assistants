(define/contract (longest-subarray nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([max-and (apply bitwise-and nums)])
    (let loop ([nums nums] [current 0] [max-len 0])
      (cond
        [(empty? nums) max-len]
        [(= (bitwise-and (first nums) max-and) max-and)
         (loop (rest nums) (add1 current) (max max-len (add1 current)))]
        [else (loop (rest nums) 0 max-len)]))))