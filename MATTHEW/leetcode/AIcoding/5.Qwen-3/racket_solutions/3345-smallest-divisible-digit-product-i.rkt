(define (smallest-divisible-digit-product n)
  (define (product-of-digits x)
    (if (= x 0)
        1
        (* (remainder x 10) (product-of-digits (quotient x 10)))))
  (let loop ((i 1))
    (if (= (remainder i (product-of-digits i)) 0)
        i
        (loop (+ i 1)))))