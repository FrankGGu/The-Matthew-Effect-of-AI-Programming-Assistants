(define (xorSumOfAllPairsBitwiseAND nums)
  (define (countBits nums)
    (for/list ([i (in-range 32)])
      (apply + (map (lambda (x) (if (bitwise-and x (bit-shift-left 1 i)) 1 0)) nums))))

  (define (calculateXorSum count)
    (for/sum ([i (in-range 32)])
      (let ([c (list-ref count i)])
        (if (zero? c)
            0
            (bitwise-shift-left (bitwise-and c (sub1 c)) i)))))

  (calculateXorSum (countBits nums)))

(xorSumOfAllPairsBitwiseAND '(1 2 3))