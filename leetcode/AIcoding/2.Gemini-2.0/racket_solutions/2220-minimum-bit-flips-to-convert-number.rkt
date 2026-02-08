(define (min-bit-flips start goal)
  (let ([xor-result (bitwise-xor start goal)])
    (let loop ([num xor-result] [count 0])
      (if (zero? num)
          count
          (loop (bitwise-and num (- num 1)) (+ count 1))))))