(define (minimum-one-bit-operations n)
  (let loop ([n n] [res 0])
    (if (zero? n)
        res
        (let ([b (bitwise-and n (- n))])
          (loop (bitwise-xor n b)
                (+ res (bitwise-not (sub1 (arithmetic-shift b 1)))))))))