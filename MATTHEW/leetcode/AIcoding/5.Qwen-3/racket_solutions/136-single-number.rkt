(define (single-number nums)
  (foldl xor 0 nums))