(define/contract (maximum-candies candies k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let ([low 1]
        [high (apply max candies)])
    (let loop ([low low]
                [high high]
                [res 0])
      (if (> low high)
          res
          (let* ([mid (quotient (+ low high) 2)]
                 [total (for/sum ([c candies]) (quotient c mid))])
            (if (>= total k)
                (loop (add1 mid) high mid)
                (loop low (sub1 mid) res))))))