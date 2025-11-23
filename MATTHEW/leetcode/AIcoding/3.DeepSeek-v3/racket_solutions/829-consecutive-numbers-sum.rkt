(define/contract (consecutive-numbers-sum n)
  (-> exact-integer? exact-integer?)
  (let loop ([k 1] [res 0])
    (let ([m (quotient (* k (add1 k)) 2)])
      (if (> m n)
          res
          (if (zero? (remainder (- n m) k))
              (loop (add1 k) (add1 res))
              (loop (add1 k) res))))))