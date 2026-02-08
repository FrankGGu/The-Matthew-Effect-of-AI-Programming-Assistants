(define (single-number nums)
  (foldl bitwise-xor 0 nums))