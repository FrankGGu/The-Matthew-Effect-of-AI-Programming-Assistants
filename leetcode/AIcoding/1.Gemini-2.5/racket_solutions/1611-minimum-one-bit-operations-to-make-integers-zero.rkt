(define (minimum-one-bit-operations n)
  (let loop ((current-n n) (result n))
    (if (= current-n 0)
        result
        (let ((shifted-n (arithmetic-shift current-n -1)))
          (loop shifted-n (bitwise-xor result shifted-n))))))