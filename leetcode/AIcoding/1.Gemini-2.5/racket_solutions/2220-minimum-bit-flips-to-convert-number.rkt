(define (min-bit-flips start goal)
  (let loop ((x (bitwise-xor start goal))
             (count 0))
    (if (= x 0)
        count
        (loop (bitwise-and x (sub1 x))
              (add1 count)))))