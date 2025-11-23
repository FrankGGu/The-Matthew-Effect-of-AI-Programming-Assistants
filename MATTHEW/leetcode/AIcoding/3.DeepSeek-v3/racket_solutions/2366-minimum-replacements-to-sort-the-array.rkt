(define/contract (minimum-replacement nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums (reverse nums)]
             [prev (first (reverse nums))]
             [res 0])
    (if (null? nums)
        res
        (let* ([current (first nums)]
               [k (ceiling (/ current prev))])
          (if (<= current prev)
              (loop (rest nums) current res)
              (loop (rest nums) (quotient current k) (+ res (- k 1))))))))