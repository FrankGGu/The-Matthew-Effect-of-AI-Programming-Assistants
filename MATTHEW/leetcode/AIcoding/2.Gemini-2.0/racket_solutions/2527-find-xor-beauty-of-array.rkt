(define (xor-beauty nums)
  (foldl (lambda (x acc) (bitwise-ior acc x)) 0 nums))