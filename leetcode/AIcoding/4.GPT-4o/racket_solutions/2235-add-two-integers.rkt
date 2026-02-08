(define (getSum a b)
  (if (= b 0)
      a
      (getSum (bitwise-xor a b) (bitwise-and a b)))
)