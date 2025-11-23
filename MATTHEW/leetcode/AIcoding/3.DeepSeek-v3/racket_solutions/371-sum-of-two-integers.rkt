(define (get-sum a b)
  (if (zero? b)
      a
      (get-sum (bitwise-xor a b) 
               (arithmetic-shift (bitwise-and a b) 1))))