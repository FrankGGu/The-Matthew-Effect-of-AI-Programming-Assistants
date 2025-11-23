(define (isPowerOfTwo n)
  (and (> n 0) (= (bitwise-and n (subtract n 1)) 0)))