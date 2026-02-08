(define (xor-beauty nums)
  (foldl bitwise-xor 0 nums))