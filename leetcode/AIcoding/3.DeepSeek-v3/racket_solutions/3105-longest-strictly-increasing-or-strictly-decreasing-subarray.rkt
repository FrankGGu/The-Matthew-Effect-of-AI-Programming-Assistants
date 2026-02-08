(define/contract (longest-monotonic-subarray nums)
  (-> (listof exact-integer?) exact-integer?)
  (define n (length nums))
  (if (<= n 1) n
      (let loop ([i 1] [inc 1] [dec 1] [max-len 1])
        (if (>= i n) max-len
            (let ([prev (list-ref nums (- i 1))]
                  [curr (list-ref nums i)])
              (cond
                [(> curr prev) (loop (+ i 1) (+ inc 1) 1 (max max-len (+ inc 1)))]
                [(< curr prev) (loop (+ i 1) 1 (+ dec 1) (max max-len (+ dec 1)))]
                [else (loop (+ i 1) 1 1 max-len)]))))))