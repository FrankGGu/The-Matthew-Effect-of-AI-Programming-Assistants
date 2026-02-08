(define (sum-of-multiples n)
  (for/sum ([i (in-range 1 (+ n 1))])
    (if (or (= (modulo i 3) 0)
            (= (modulo i 5) 0)
            (= (modulo i 7) 0))
        i
        0)))