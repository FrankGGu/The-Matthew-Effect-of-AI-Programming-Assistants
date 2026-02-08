(define (minCoins coins amount)
  (define (dp n)
    (if (= n 0) 0
        (if (< n 0) +inf.0
            (foldl (lambda (coin acc)
                      (min acc (add1 (dp (- n coin)))))
                    +inf.0 coins))))
  (let ((result (dp amount)))
    (if (= result +inf.0) -1 result)))

(define (coinChange coins amount)
  (minCoins coins amount))