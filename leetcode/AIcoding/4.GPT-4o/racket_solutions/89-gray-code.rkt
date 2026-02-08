(define (grayCode n)
  (map (lambda (x) (bitwise-xor x (ash x -1))) (range (expt 2 n))))