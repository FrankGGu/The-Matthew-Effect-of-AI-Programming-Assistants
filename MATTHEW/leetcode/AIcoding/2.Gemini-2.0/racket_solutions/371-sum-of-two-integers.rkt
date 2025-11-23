(define (get-sum a b)
  (if (= b 0)
      a
      (get-sum (bitwise-xor a b) (bitwise-and a b) 1)))