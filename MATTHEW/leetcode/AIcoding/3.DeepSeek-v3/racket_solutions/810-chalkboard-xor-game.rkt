(define (xor-game nums)
  (let ([xor-all (foldl bitwise-xor 0 nums)])
    (or (zero? xor-all)
        (even? (length nums)))))