(define/contract (smallest-divisible-digit-product n)
  (-> exact-positive-integer? exact-positive-integer?)
  (define (digit-product x)
    (let loop ([x x] [prod 1])
      (if (zero? x)
          prod
          (loop (quotient x 10) (* prod (remainder x 10))))))
  (let loop ([i 1])
    (if (and (zero? (remainder i n)) (zero? (remainder (digit-product i) n)))
        i
        (loop (+ i 1)))))