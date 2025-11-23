(define (find-complement num)
  (define (bit-length n)
    (if (= n 0) 0
        (+ 1 (bit-length (floor (/ n 2))))))
  (define len (bit-length num))
  (define mask (sub1 (expt 2 len)))
  (bitwise-xor num mask))