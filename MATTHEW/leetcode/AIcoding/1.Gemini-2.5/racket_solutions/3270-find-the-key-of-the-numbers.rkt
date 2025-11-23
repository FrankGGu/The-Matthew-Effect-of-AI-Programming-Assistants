(define (find-the-key-of-the-numbers nums)
  (foldl (lambda (x acc) (bitwise-xor x acc)) 0 nums))