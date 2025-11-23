(define/contract (hamming-weight n)
  (-> exact-integer? exact-integer?)
  (let loop ([n n] [count 0])
    (if (zero? n)
        count
        (loop (arithmetic-shift n -1) (+ count (bitwise-and n 1))))))