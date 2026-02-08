(define (single-number nums)
  (foldl (lambda (x acc) (bit-xor x acc)) 0 nums))