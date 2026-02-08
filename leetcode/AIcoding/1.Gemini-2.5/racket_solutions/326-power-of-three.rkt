(define (isPowerOfThree n)
  (and
   (> n 0)
   (= (remainder 1162261467 n) 0)))