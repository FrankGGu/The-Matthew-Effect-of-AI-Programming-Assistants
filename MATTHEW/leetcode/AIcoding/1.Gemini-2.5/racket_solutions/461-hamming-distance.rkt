(define (hammingDistance x y)
  (let loop ((xor-val (bitwise-xor x y))
             (count 0))
    (if (= xor-val 0)
        count
        (loop (bitwise-and xor-val (sub1 xor-val))
              (add1 count)))))