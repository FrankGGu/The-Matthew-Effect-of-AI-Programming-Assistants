(define (bitwiseComplement n)
  (if (= n 0)
      1
      (let* ((bit-length (floor (log n 2)))
             (mask (- (expt 2 (+ bit-length 1)) 1)))
        (bitwise-and (bitwise-xor n mask) mask))))