(define (max-num-of-marked-indices nums)
  (let loop ([nums (sort nums <)]
             [i 0]
             [j (quotient (length nums) 2)]
             [res 0])
    (if (or (>= i (quotient (length nums) 2)) (>= j (length nums)))
        (* 2 res)
        (if (<= (* 2 (list-ref nums i)) (list-ref nums j))
            (loop nums (+ i 1) (+ j 1) (+ res 1))
            (loop nums i (+ j 1) res)))))