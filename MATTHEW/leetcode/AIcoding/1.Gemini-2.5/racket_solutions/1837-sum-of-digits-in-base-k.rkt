(define (sum-base n k)
  (let loop ((current-n n) (total-sum 0))
    (if (= current-n 0)
        total-sum
        (loop (quotient current-n k)
              (+ total-sum (remainder current-n k))))))