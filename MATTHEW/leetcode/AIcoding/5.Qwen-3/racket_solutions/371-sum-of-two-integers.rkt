(define (get-sum a b)
  (if (= b 0)
      a
      (get-sum (bitwise-xor a b) (bitwise-and (bitwise-not (bitwise-xor a b)) (arithmetic-shift b 1)))))