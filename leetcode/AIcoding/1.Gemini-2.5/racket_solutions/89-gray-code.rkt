(define (gray-code n)
  (let* ([num-elements (expt 2 n)]
         [indices (build-list num-elements identity)])
    (map (lambda (k) (bitwise-xor k (quotient k 2)))
         indices)))