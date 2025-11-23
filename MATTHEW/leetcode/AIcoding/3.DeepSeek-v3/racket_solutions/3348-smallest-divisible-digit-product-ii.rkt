(define/contract (smallest-divisible-digit-product n)
  (-> exact-positive-integer? exact-positive-integer?)
  (let loop ([num 1])
    (if (and (positive? (digit-product num)) (zero? (modulo num n)))
        num
        (loop (add1 num)))))

(define (digit-product n)
  (let loop ([n n] [prod 1])
    (cond
      [(zero? n) (if (= prod 1) 0 prod)]
      [else (loop (quotient n 10) (* prod (modulo n 10)))])))