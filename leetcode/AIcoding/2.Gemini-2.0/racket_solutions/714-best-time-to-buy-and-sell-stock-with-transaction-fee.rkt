(define (max-profit prices fee)
  (let ([n (length prices)])
    (if (zero? n)
        0
        (let loop ([i 1]
                   [hold (- (first prices))]
                   [cash 0])
          (if (= i n)
              cash
              (let ([price (list-ref prices i)])
                (loop (+ i 1)
                      (max hold (- cash price))
                      (max cash (+ hold price) (- fee)))))))))