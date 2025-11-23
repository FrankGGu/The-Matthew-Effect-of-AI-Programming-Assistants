(define (minimize-maximum-of-array nums)
  (let loop ([i 0] [prefix-sum 0] [max-val 0])
    (if (= i (length nums))
        max-val
        (let ([new-prefix-sum (+ prefix-sum (list-ref nums i))])
          (let ([avg (ceiling (/ new-prefix-sum (+ i 1)))])
            (loop (+ i 1) new-prefix-sum (max max-val avg)))))))