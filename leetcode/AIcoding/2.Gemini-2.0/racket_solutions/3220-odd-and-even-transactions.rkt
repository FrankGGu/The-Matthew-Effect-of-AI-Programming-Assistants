(define (odd-even-transactions transactions)
  (let loop ([transactions transactions]
             [odd-sum 0]
             [even-sum 0]
             [index 1])
    (cond
      [(empty? transactions) (if (> odd-sum even-sum) "Odd" "Even")]
      [else (let ([transaction (first transactions)])
              (if (odd? index)
                  (loop (rest transactions) (+ odd-sum transaction) even-sum (+ index 1))
                  (loop (rest transactions) odd-sum (+ even-sum transaction) (+ index 1))))])))