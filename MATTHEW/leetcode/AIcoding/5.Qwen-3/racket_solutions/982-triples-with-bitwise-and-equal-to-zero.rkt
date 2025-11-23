(define/contract (count-triplets nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([n (length nums)])
    (let loop ([i 0] [res 0])
      (if (= i n)
          res
          (loop (+ i 1) (+ res (let ([a (list-ref nums i)])
                                (let loop2 ([j (+ i 1)] [cnt 0])
                                  (if (= j n)
                                      cnt
                                      (let ([b (list-ref nums j)])
                                        (let loop3 ([k (+ j 1)] [cnt2 cnt])
                                          (if (= k n)
                                              cnt2
                                              (if (= (bitwise-and a b (list-ref nums k)) 0)
                                                  (loop3 (+ k 1) (+ cnt2 1))
                                                  (loop3 (+ k 1) cnt2))))))))) ))))