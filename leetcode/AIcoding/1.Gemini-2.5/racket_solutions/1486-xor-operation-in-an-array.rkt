(define/public (xor-operation n start)
  (for/fold ([result 0])
            ([i (in-range n)])
    (bitwise-xor result (+ start (* 2 i)))))