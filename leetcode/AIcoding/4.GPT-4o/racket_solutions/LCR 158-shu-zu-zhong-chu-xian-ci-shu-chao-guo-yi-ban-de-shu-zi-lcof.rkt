(define (get-money-amount n)
  (define (dp start end)
    (if (>= start end) 0
        (let loop ((i start) (min-amount +inf.0))
          (if (> i end)
              min-amount
              (loop (+ i 1) (min min-amount (+ i (max (dp start (- i 1)) (dp (+ i 1) end))))))))
    )
  (dp 1 n))

(get-money-amount n)