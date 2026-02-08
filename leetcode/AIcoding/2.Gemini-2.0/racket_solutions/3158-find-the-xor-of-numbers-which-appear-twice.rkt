(define (single-number nums)
  (foldl (lambda (x acc) (bitwise-xor x acc)) 0 nums))