(define (min-flips a b c)
  (let loop ([a a] [b b] [c c] [count 0])
    (if (and (= a 0) (= b 0) (= c 0))
        count
        (let ([bit-a (modulo a 2)]
              [bit-b (modulo b 2)]
              [bit-c (modulo c 2)])
          (if (= (bitwise-ior bit-a bit-b) bit-c)
              (loop (quotient a 2) (quotient b 2) (quotient c 2) count)
              (if (= bit-c 0)
                  (loop (quotient a 2) (quotient b 2) (quotient c 2) (+ count (+ bit-a bit-b)))
                  (loop (quotient a 2) (quotient b 2) (quotient c 2) (+ count 1))))))))