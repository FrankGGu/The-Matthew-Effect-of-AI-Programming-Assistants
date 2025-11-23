(define (countBitChanges x y)
  (define (hammingDistance a b)
    (let loop ((n (bitwise-xor a b)) (count 0))
      (if (zero? n)
          count
          (loop (bitwise-arithmetic-shift-right n 1) (+ count (bitwise-and n 1))))))
  (hammingDistance x y))