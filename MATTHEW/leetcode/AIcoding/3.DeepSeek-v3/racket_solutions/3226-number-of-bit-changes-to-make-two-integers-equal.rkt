(define (bit-changes x y)
  (let ((xor-result (bitwise-xor x y)))
    (let loop ((n xor-result) (count 0))
      (if (zero? n)
          count
          (loop (arithmetic-shift n -1) (+ count (bitwise-and n 1))))))))