(define (circular-permutation n start)
  (let loop ([i 0] [result '()])
    (if (= i (expt 2 n))
        result
        (let ([gray-code (bitwise-xor i (arithmetic-shift i -1))])
          (loop (+ i 1) (append result (list (bitwise-xor start gray-code))))))))