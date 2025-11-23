(define (construct-the-minimum-bitwise-array-i n k)
  (if (= (remainder n 2) 1)
      k
      0))