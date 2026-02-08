(define (xor-operation n start)
  (let loop ([i 0] [result 0])
    (if (= i n)
        result
        (loop (+ i 1) (bitwise-xor result (+ start (* i 2)))))))