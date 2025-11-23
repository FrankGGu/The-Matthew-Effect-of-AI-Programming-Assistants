(define (minimum-one-bit-operations n)
  (if (= n 0)
      0
      (- (bitwise-xor n (arithmetic-shift n -1)) (minimum-one-bit-operations (arithmetic-shift n -1)))))