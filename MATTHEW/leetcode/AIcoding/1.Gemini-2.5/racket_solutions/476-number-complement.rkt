(define (find-complement num)
  (let* ((num-bits (integer-length num))
         (mask (- (expt 2 num-bits) 1)))
    (bitwise-xor num mask)))