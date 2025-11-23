(define (bitwise-complement n)
  (if (zero? n)
      1
      (bitwise-xor n (sub1 (expt 2 (integer-length n))))))