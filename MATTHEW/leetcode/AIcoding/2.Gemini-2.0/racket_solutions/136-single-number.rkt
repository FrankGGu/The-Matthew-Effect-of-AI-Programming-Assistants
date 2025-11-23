(define (single-number nums)
  (foldl (lambda (x acc) (xor x acc)) 0 nums))