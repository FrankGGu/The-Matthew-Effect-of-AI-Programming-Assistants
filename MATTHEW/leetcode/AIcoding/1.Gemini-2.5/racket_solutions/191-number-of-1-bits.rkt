(define (hamming-weight n)
  (let loop ((num n) (count 0))
    (if (zero? num)
        count
        (loop (bitwise-and num (sub1 num))
              (add1 count)))))