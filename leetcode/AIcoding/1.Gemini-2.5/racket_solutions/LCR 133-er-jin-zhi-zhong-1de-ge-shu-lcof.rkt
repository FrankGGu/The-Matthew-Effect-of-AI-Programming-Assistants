(define (hamming-weight n)
  (let loop ((num n) (count 0))
    (if (= num 0)
        count
        (loop (arithmetic-shift num -1)
              (+ count (bitwise-and num 1))))))