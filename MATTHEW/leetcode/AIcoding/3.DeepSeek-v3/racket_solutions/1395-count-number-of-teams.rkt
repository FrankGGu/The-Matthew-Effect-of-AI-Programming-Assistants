(define/contract (num-teams rating)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [count 0])
    (if (>= i (length rating))
        count
        (let loop-j ([j (add1 i)] [count count])
          (if (>= j (length rating))
              (loop (add1 i) count)
              (let loop-k ([k (add1 j)] [count count])
                (if (>= k (length rating))
                    (loop-j (add1 j) count)
                    (let ([ri (list-ref rating i)]
                          [rj (list-ref rating j)]
                          [rk (list-ref rating k)])
                      (loop-k (add1 k) 
                              (if (or (and (< ri rj) (< rj rk))
                                      (and (> ri rj) (> rj rk)))
                                  (add1 count)
                                  count))))))))))