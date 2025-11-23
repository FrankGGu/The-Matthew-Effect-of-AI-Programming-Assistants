(define (neighboringBitwiseXOR derived)
  (define (xor-sum lst)
    (foldl bitwise-xor 0 lst))
  (= (xor-sum derived) 0))