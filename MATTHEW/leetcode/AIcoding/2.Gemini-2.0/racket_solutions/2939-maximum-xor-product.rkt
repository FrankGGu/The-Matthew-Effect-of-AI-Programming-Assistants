(define (maximum-xor-product a b p n)
  (define (mod x)
    (modulo x p))
  (define (max-xor a b mask)
    (cond
      [(and (zero? (bitwise-and a mask)) (zero? (bitwise-and b mask)))
       (let ([a1 (bitwise-ior a mask)]
             [b1 (bitwise-ior b mask)])
         (cond
           [(= (bitwise-xor a1 b) (bitwise-xor b1 a)) (mod (* a1 b1))]
           [(> (bitwise-xor a1 b) (bitwise-xor b1 a)) (mod (* a1 b))]
           [else (mod (* a b1))]))]
      [(and (not (zero? (bitwise-and a mask))) (not (zero? (bitwise-and b mask))))
       (mod (* a b))]
      [(zero? (bitwise-and a mask))
       (mod (* (bitwise-ior a mask) b))]
      [else
       (mod (* a (bitwise-ior b mask)))]))

  (let loop ([i (- n 1)] [a a] [b b] [ans 1])
    (if (< i 0)
        ans
        (let ([mask (arithmetic-shift 1 i)])
          (loop (- i 1) a b (mod (* ans (max-xor a b mask))))))))