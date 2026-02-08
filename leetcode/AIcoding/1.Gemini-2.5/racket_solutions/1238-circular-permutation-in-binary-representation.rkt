(define (circular-permutation n start)
  (let ((num-elements (expt 2 n)))
    (for/list ([i (in-range num-elements)])
      (bitwise-xor (bitwise-xor i (quotient i 2)) start))))