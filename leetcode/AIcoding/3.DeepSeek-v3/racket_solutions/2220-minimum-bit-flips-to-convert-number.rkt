(define (min-bit-flips start goal)
  (let ((xor-result (bitwise-xor start goal)))
    (let loop ((n xor-result) (count 0))
      (if (= n 0)
          count
          (loop (bitwise-and n (sub1 n)) (add1 count))))))