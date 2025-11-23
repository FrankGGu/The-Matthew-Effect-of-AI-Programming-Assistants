(define (checkBitwiseOrHasTrailingZeros nums)
  (let ([or-result (apply bitwise-ior nums)])
    (= (bitwise-and or-result (- or-result 1)) 0)))

(checkBitwiseOrHasTrailingZeros '(1 2 3))