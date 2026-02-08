(define (find-complement num)
  (let loop ([n num] [mask 1])
    (if (< n mask)
        (- mask 1)
        (loop n (arithmetic-shift mask 1)))))
(define (bitwise-complement num)
  (if (zero? num)
      1
      (bitwise-xor num (find-complement num))))