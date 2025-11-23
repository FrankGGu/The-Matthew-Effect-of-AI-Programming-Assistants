(define (xorOperation n start)
  (define (xor-accum acc i)
    (if (= i n)
        acc
        (xor-accum (bitwise-xor acc (+ start (* 2 i))) (+ i 1))))
  (xor-accum 0 0))