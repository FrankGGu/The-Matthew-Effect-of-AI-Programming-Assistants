(define (max-profit prices discounts money)
  (let loop ([i 0] [money money] [profit 0])
    (if (>= i (vector-length prices))
        profit
        (let ([price (vector-ref prices i)]
              [discount (vector-ref discounts i)])
          (if (<= price money)
              (max (loop (add1 i) money profit)
                   (loop (add1 i) (- money price) (+ profit discount)))
              (loop (add1 i) money profit))))))